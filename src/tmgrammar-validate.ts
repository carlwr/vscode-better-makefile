/*
  core logic for validating VS Code textmate grammars

  the core of the validation is finding the regexes in a textMate grammar file and exercising the oniguruma regexes.

  principle: use the oniguruma .wasm binary from the vscode-oniguruma package to validate regexes - this is what vscode uses, so for validation to be as accurate as possible, we want to use the same regex engine, as far as possible.

  implementation notes:
  - using the .wasm binary from the vscode-oniguruma package requires a bit of a hack - we use a heuristic to find the compiled .wasm binary that is included with the vscode-oniguruma package.
*/

import * as fs from "node:fs";
import arg from 'arg';
import * as globby from 'globby';
import * as vscTM from 'vscode-textmate';
import { pkgJson } from './pkgJson.js';

/* NOTE about using the 'vscode-textmate' import:
use...
  vscTM.default.<member>    ...for runtime
  vscTM.<Type>              ...for types

details, background:
  - (the below is probably true for both vscode-textmate and vscode-oniguruma)
  - for this/these packages, there is seemingly some deficiency in how the module interface is exported and/or how the .d.ts files are generated - in a way that can cause a runtime TypeError even though typechecker and linter are happy.
*/


const VSC_ONIG = 'vscode-oniguruma';

const vscOnigImport = import('vscode-oniguruma');

const loadOnigWasm = memoized(getVscOnig);

const argsSpec = {
  '--watch': Boolean,
  '--no-regex-validation': Boolean,
  '--no-snips-validation': Boolean,
  '-v': arg.COUNT,
}


interface Regex {
  rgx: string
  pth: string
}

interface RegexError {
  pth: string
  pat: string
  err: string
}

interface TokenDetails {
  line: number
  text: string
  token: vscTM.IToken
}

interface SnipResult {
  snip: string
  tokens: number
  lines: number
  unclassed: string[]
  details: TokenDetails[]
}



export async function validateGrammar(
  grammarPath: string,
  scopeName: string,
  snippets?: string[]
): Promise<void> {

  const args = arg(argsSpec, { permissive: true });

  log1("\ngrammar validation");
  log1(  "==================");

  const rawGrammar = loadRawGrammar(grammarPath);

  if (!args['--no-regex-validation']) {
    const regexes = findRegexes(rawGrammar);
    log1(`\nRegexes: info: found ${regexes.length} regexes in the grammar`);
    const results = await testRegexes(regexes)
    reportRegexes(results);
  }

  if (!args['--no-snips-validation'] && snippets) {
    const results = await testSnippets(snippets, rawGrammar, scopeName);
    reportSnippets(results);
  }

  log1(  "==================\n");
};



function loadRawGrammar(
  grammarPath: string,
): vscTM.IRawGrammar {
  const contents = fs.readFileSync(grammarPath, "utf8")
  return JSON.parse(contents) as vscTM.IRawGrammar;
}


async function getVscOnig(): Promise<vscTM.IOnigLib> {
  const vscOnig = await vscOnigImport;
  await vscOnig.loadWASM(getOnigWasmBin());
  return vscOnig;
}


function getOnigWasmPath(): string {
  const vscOnig = `${VSC_ONIG}@${getVscOnigVersion()}`
  const pthGlob = `node_modules/**/${vscOnig}/**/onig.wasm`
  const matches = globby.globbySync(pthGlob, { dot: true} );
  if (matches.length === 0) {
    throw new Error(`could not find onig.wasm for ${vscOnig}.`);
  }
  return matches[0];
}


function getVscOnigVersion(): string {

  const DEV_DEPS = pkgJson.devDependencies;
  if (!DEV_DEPS) {
    throw new Error('devDependencies not found in package.json');
  }

  const version = DEV_DEPS[VSC_ONIG];
  if (!version) {
    throw new Error(`${VSC_ONIG} not found as a devDependency in package.json`);
  }

  const validRE = /^[0-9.]+$/;
  if (!validRE.test(version)) {
    throw new Error(`The version spec for ${VSC_ONIG} in package.json is '${version}' which does not match the expected format /${validRE.source}/. In order to use the oniguruma wasm binary, the version declared in package.json must be an exact version number, e.g. "2.0.1".`);
  }

  return version;
}


function getOnigWasmBin(): ArrayBuffer {
  const onigPath = getOnigWasmPath();
  const wasmBin = fs.readFileSync(onigPath).buffer;
  return wasmBin;
}


function findRegexes(obj: unknown, path = ''): Regex[] {
  if (!obj || typeof obj !== 'object') return [];

  type T = Record<string, unknown>;

  const getDirectRegexes = () =>
    (['match', 'begin', 'end'])
      .flatMap(k => {
        const v = (obj as T)[k];
        return typeof v === 'string' ? [{ rgx: v, pth: `${path}.${k}` }] : [];
      });

  const getChildRegexes = () =>
    Object.entries(obj as T).flatMap(([k, v]) => {
      const curPath = buildPath(path, k);

      if (k === 'patterns' && Array.isArray(v)) {
        return v.flatMap((v, i) => findRegexes(v, buildPath(curPath, '', i)));
      }

      if (k === 'repository' && typeof v === 'object' && v !== null) {
        return Object.entries(v as T).flatMap(([k, v]) =>
          findRegexes(v, buildPath(curPath, k))
        );
      }

      return typeof v === 'object' && v !== null ? findRegexes(v, curPath) : [];
    });

  return [...getDirectRegexes(), ...getChildRegexes()];
};


function buildPath(pth: string, key: string, i?: number): string {
  return pth
    ? `${pth}${i !== undefined ? `[${i}]` : `.${key}`}`
    : `${key}${i !== undefined ? `[${i}]` : ''}`;
}


async function testRegexes(regexes: Regex[]): Promise<RegexError[]> {
  const onigLib = await loadOnigWasm();
  const errors: RegexError[] = [];
  for (const re of regexes) {
    const error = validateRegex(re, onigLib);
    if (error) {
      errors.push(error);
    } else {
      log2(`OK: valid regex:\n  ${re.pth}\n  ${re.rgx}`);
    }
  }
  return errors;
};


function validateRegex(re: Regex, onigLib: vscTM.IOnigLib): RegexError | undefined {
  try {
    onigLib.createOnigScanner([re.rgx]);
  } catch (error) {
    return {
      pth: re.pth,
      pat: re.rgx,
      err: String(error),
    };
  }
}


export async function testSnippets(
  snippets: string[],
  rawGrammar: vscTM.IRawGrammar|null,
  scopeName: string,
): Promise<SnipResult[]> {

  const registry = new vscTM.default.Registry({
    onigLib: loadOnigWasm(),
    loadGrammar: s => Promise.resolve(s === scopeName ? rawGrammar : null)
  });

  const grammar: vscTM.IGrammar | null = await registry.loadGrammar(scopeName);
  if (!grammar) throw new Error(`grammar for '${scopeName}' not found`);
  const results = snippets.map(snip =>
    testSnippet(grammar, snip, scopeName)
  );
  return results;
}


function testSnippet(
  grammar: vscTM.IGrammar,
  snippet: string,
  scopeName: string
): SnipResult {
  const lines = snippet.split('\n');
  let ruleStack: vscTM.StateStack | null = null;
  let tokens = 0;
  const unclassed: string[] = [];
  const details: TokenDetails[] = [];

  lines.forEach((line, i) => {
    if (!line.trim()) return;

    const lineTokens = grammar.tokenizeLine(line, ruleStack);
    tokens += lineTokens.tokens.length;

    lineTokens.tokens.forEach(token => {
      const text = line.substring(token.startIndex, token.endIndex);
      details.push(
        { line: i + 1,
          token: token,
          text: text
        });

      if (
        token.scopes.length === 1 &&
        token.scopes[0] === scopeName &&
        text.trim()
      ) {
        unclassed.push(`line ${i+1}: "${text}"`);
      }
    });

    ruleStack = lineTokens.ruleStack;
  });

  return {
    snip: snippet,
    tokens: tokens,
    lines: lines.length,
    unclassed: unclassed,
    details: details
  };
};


function reportRegexes(errors: RegexError[]): void {
  if (errors.length > 0) {
    console.error("\nRegexes: validation errors:");
    console.error(  "---------------------------");
    errors.forEach(e => {
      console.error(`\nPATH:      ${e.pth}`);
      console.error(  `PATTERN:   ${e.pat}`);
      console.error(  `ERROR:     ${e.err}`);
    });
    throw new Error(`${errors.length} invalid regexes in grammar`);
  } else {
    log1("\nRegexes: OK; all valid");
  }
};


function reportSnippets(results: SnipResult[]): void {
  const failedSnips = results.filter(r => r.unclassed.length > 0).length;
  const totalUnclassed = results.reduce((sum, r) => sum + r.unclassed.length, 0);

  log2("\nSnippets:");
  log2(  "---------");

  results.forEach((res, i) => {
    log2(`\nsnippet #${i+1}:`);
    log2(`  text: "${res.snip.replace(/\n/g, '\\n')}"`);
    log2(`  lines: ${res.lines}`);
    log2(`  tokens: ${res.tokens}`);

    log2(`  unclassified: ${res.unclassed.length} segments`);
    res.unclassed.forEach(u => log2(`    - ${u}`));

    log3(`  token details:`);
    res.details.forEach(({ line, text, token }) => {
      const loc = `${line}:${token.startIndex}:${token.endIndex}`;
      const detailsLines = [
        `    ${loc} "${text}"`,
        `      ${token.scopes.join('\n      ')}`
      ];
      log3(detailsLines.join('\n'));
    });

  });

  log2("\n")

  const unclassedDetails = failedSnips > 0 ? ` (${failedSnips} snippets)` : '';
  const resultLines: string[] = [
    `Snippets:`,
    `  tokenized snippets:     ${results.length}`,
    `  unclassified segments:  ${totalUnclassed}  ${unclassedDetails}`,
  ];
  log1(resultLines.join('\n'));
};


/*
 * utility functions
 */

// Cached, lazy single-flight evaluation of a promise.
// A rejected promise is cached as well, i.e. no re-attempts (failures are assumed to be permanent)
function memoized<T>(f: () => Promise<T>): () => Promise<T> {
  let p: Promise<T> | null = null;
  return () => p ?? (p = f())
}

const mkLogger = ( () => {
  let verbosity: number|null = null;
  return (verbosityThreshold: number) => {
    return (s: string) => {
      const v = verbosity ?? (verbosity = getVerbosity());
      if (v >= verbosityThreshold) { console.log(s) }
    }
  }
})()

function getVerbosity(): number {
  const args = arg(argsSpec, { permissive: true });
  return args['-v'] ?? 0;
}

const log1 = mkLogger(1);
const log2 = mkLogger(2);
const log3 = mkLogger(3);
