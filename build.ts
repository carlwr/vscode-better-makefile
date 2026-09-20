import fs from 'node:fs/promises'
import path from 'node:path'
import * as tmv from '@carlwr/textmate-validate'
import * as yaml from '@eemeli/yaml'
import Ajv from 'ajv'
import arg from 'arg'
import chokidar from 'chokidar'
import sortKeysRecursive from 'sort-keys-recursive'
import * as cfg from './src/cfg.js'

const args = arg(
  { '--watch': Boolean, '--out-dir': String },
  { permissive: true },
)

type SomeRecord = Record<string, unknown>

const ANCHOR_PREFIX = '__'

const KEYS_TO_TOP = [
  'name',
  'scopeName',
  'comment',
  'information_for_contributors',
]

run().catch((err: unknown) => {
  console.error('Unhandled error:', err)
  process.exit(1)
})

async function run() {
  const doWatch = args['--watch'] ?? false
  await build()
  if (doWatch) {
    watch(() => {
      void build()
    })
  }
}

async function build() {
  const outDir = args['--out-dir'] ?? path.dirname(cfg.GRAMMAR_JSON)
  const jsonPath = path.join(outDir, path.basename(cfg.GRAMMAR_JSON))
  const yamlText = await fs.readFile(cfg.GRAMMAR_YAML, 'utf8')
  const jsonObj = yaml.parse(yamlText) as SomeRecord
  const dropped = dropAnchorHolders(jsonObj)
  const sortedJsonObj = sortKeysRecursive(jsonObj)
  const orderedJsonObj = hoistKeysToTop(sortedJsonObj)
  const jsonText = JSON.stringify(orderedJsonObj, null, 2)
  assertUnreferenced(dropped, jsonText)
  const asWritten = JSON.parse(jsonText) as SomeRecord

  await schemaValidate(asWritten)
  console.log(`DONE: schema OK:  ${jsonPath}.`)

  await fs.mkdir(outDir, { recursive: true })
  await fs.writeFile(jsonPath, jsonText)
  console.log(`DONE: wrote:      ${jsonPath}.`)

  await tmvValidate(jsonPath)
  console.log(`DONE: validated:  ${jsonPath}.`)

  console.log('')
}

function watch(cb: () => void) {
  chokidar.watch(cfg.GRAMMAR_YAML, { persistent: true }).on('change', cb)
}

/**
 * Drop YAML anchors; no reason to keep them in the generated json.
 */
function dropAnchorHolders(obj: SomeRecord): string[] {
  const repository = (obj.repository ?? {}) as SomeRecord
  const dropped: string[] = []
  for (const map of [obj, repository]) {
    for (const key of Object.keys(map)) {
      if (key.startsWith(ANCHOR_PREFIX)) {
        delete map[key]
        dropped.push(key)
      }
    }
  }
  return dropped
}

function hoistKeysToTop(obj: SomeRecord): SomeRecord {
  const first = KEYS_TO_TOP.filter(key => key in obj)
  const rest = Object.keys(obj).filter(key => !first.includes(key))
  return Object.fromEntries([...first, ...rest].map(key => [key, obj[key]]))
  // using the fact that both `JSON.stringify` and the object itself iterate string keys in insertion order
}

function assertUnreferenced(dropped: string[], jsonText: string) {
  const stillIncluded = dropped.filter(key => jsonText.includes(`"#${key}"`))
  if (stillIncluded.length > 0) {
    throw new Error(`dropped, but still included: ${stillIncluded.join(', ')}`)
  }
}

async function schemaValidate(jsonObj: SomeRecord) {
  const schemaText = await fs.readFile(cfg.TMATE_SCHEMA, 'utf8')
  const schema = JSON.parse(schemaText) as SomeRecord
  const ajv = new Ajv.Ajv()
  if (!ajv.validate(schema, jsonObj)) {
    throw new Error(ajv.errorsText())
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
