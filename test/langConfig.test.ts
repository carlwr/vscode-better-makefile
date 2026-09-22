import assert from 'node:assert/strict'
import { readFileSync } from 'node:fs'
import * as cfg from '../src/cfg.js'

// Vendored from vscode. Its default word pattern is this class plus a numeric branch (redundant once `-` and `.` are word characters)
// from: https://github.com/microsoft/vscode/blob/6b924c5/src/vs/editor/common/core/wordHelper.ts
const USUAL_WORD_SEPARATORS = '`~!@#$%^&*()-=+[{]}\\|;:\'",.<>/?'

function wordCharClass(allowInWords: string) {
  let source = '[^'
  for (const sep of USUAL_WORD_SEPARATORS) {
    if (allowInWords.includes(sep)) continue
    source += `\\${sep}`
  }
  return `${source}\\s]+`
}

// `-` and `.` are ordinary characters in makefile target and variable names
const expected = wordCharClass('-.')

assert.deepEqual(
  '.PHONY: my-target\nmy-var := $(dir-1)/f.o'.match(new RegExp(expected, 'g')),
  ['.PHONY', 'my-target', 'my-var', 'dir-1', 'f.o'],
)

assert.equal(
  new RegExp(expected).test(''),
  false,
  'a word pattern matching the empty string hangs the editor',
)

const langConfig = JSON.parse(readFileSync(cfg.LANG_CONFIG, 'utf8')) as {
  wordPattern: string
}

assert.equal(
  langConfig.wordPattern,
  expected,
  'commit the derived pattern verbatim, escaping included',
)

console.log('langConfig: passed')
