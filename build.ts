import fs from 'node:fs/promises';
import * as tmv from '@carlwr/textmate-validate'
import * as yaml from '@eemeli/yaml';
import Ajv from 'ajv';
import arg from 'arg';
import chokidar from 'chokidar';
import sortKeysRecursive from 'sort-keys-recursive';
import * as cfg from './src/cfg.js';


const args = arg({'--watch': Boolean}, { permissive: true });

type SomeRecord = Record<string, unknown>;


run().catch((err: unknown) => {
  console.error('Unhandled error:', err);
  process.exit(1);
});


async function run() {
  const doWatch = args['--watch'] ?? false;
  await build();
  if (doWatch) { watch(() => { void build(); }) }
}


async function build() {
  const yamlText      = await fs.readFile(cfg.GRAMMAR_YAML, 'utf8');
  const jsonObj       = yaml.parse(yamlText) as SomeRecord;
  const sortedJsonObj = sortKeysRecursive(jsonObj);
  const jsonText      = JSON.stringify(sortedJsonObj, null, 2);

  await fs.writeFile(cfg.GRAMMAR_JSON, jsonText);
  console.log(`DONE: wrote:      ${cfg.GRAMMAR_JSON}.`);

  await schemaValidate(sortedJsonObj);
  console.log(`DONE: schema OK:  ${cfg.GRAMMAR_JSON}.`);

  await tmvValidate(cfg.GRAMMAR_JSON);
  console.log(`DONE: validated:  ${cfg.GRAMMAR_JSON}.`);

  console.log('')
}


function watch(cb: () => void) {
  chokidar.watch(cfg.GRAMMAR_YAML, { persistent: true }).on('change', cb);
}


async function schemaValidate(jsonObj: SomeRecord) {
  const schemaText = await fs.readFile(cfg.TMATE_SCHEMA, 'utf8');
  const schema = JSON.parse(schemaText) as SomeRecord;
  const ajv = new Ajv.Ajv();
  if (!ajv.validate(schema, jsonObj)) {
    throw new Error(ajv.errorsText());
  }
}

async function tmvValidate(jsonPath: string) {
  const result = await tmv.validateGrammar(jsonPath)
  if (!tmv.passed(result)) {
    const verbosity = 2
    const compact = false
    tmv.printResult(result, verbosity, compact)
    throw new Error('FAILED: textmate-validate')
  }
}
