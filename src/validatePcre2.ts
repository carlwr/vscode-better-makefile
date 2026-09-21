import { spawnSync } from 'node:child_process'
import type {
  GrammarResult,
  GrammarSource,
  RegexResult,
} from '@carlwr/textmate-validate'
import { getGrammarRegexes } from '@carlwr/textmate-validate'

const PCRE2GREP = 'pcre2grep'
// pick `pcre2grep` for detecting illegal PCRE2 regexes e.g. since it has distinct, documented exit codes if given an illegal PCRE2 regex

const PCRE2GREP_OPTIONS = [
  '--utf', // regex compilation flag that e.g. Linguist (GitHub) uses
]

const PCRE2GREP_EXITCODE_NOMATCH = 1
const PCRE2GREP_EXITCODE_FAILURE = 2

/**
 * Report whether each regex in the grammar compiles as a PCRE2 regex.
 *
 * Requires `pcre2grep` to be installed on the local system.
 *
 * (Note: this function cannot guarantee that a regex when interpreted as a PCRE2 regex behaves the same as if interpreted as an Oniguruma regex.)
 */
export async function validateGrammarPcre2(
  source: GrammarSource,
): Promise<GrammarResult> {
  const regexes = await getGrammarRegexes(source)
  return regexes.map(re => ({ ...re, ...validateRegexPcre2(re.rgx) }))
}

function validateRegexPcre2(rgx: string): RegexResult {
  const args = [...PCRE2GREP_OPTIONS, '-e', rgx]
  const r = spawnSync(PCRE2GREP, args, { input: '', encoding: 'utf8' })
  if (r.error) throw new Error(`${PCRE2GREP}: ${r.error.message}`)
  switch (r.status) {
    case PCRE2GREP_EXITCODE_NOMATCH:
      return { valid: true }
    case PCRE2GREP_EXITCODE_FAILURE:
      return { valid: false, err: r.stderr.trim() }
    default:
      throw new Error(
        `${PCRE2GREP}: unexpected exit status ${r.status}\n${r.stdout}${r.stderr}`,
      )
  }
}
