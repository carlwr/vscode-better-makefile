import * as readPkg from 'read-pkg'
import { z } from 'zod'

const pkgJsonSchema = z.object({
  name: z.string(),
  contributes: z.object({
    grammars: z.array(z.object({
      path: z.string(),
      scopeName: z.string(),
    })),
  })
})

function parsePkgJson() {
  try {
    const pkg = readPkg.readPackageSync()
    return pkgJsonSchema.required().parse(pkg)
  } catch (e) {
    console.error(e)
    process.exit(1)
  }
}

const pkgJson = parsePkgJson()

export const TMATE_SCHEMA   = 'schemas/tmLanguage.schema.json'
export const GRAMMAR_YAML   = 'src/makefile.tmLanguage.yaml'
export const GRAMMAR_JSON   = pkgJson.contributes.grammars[0]!.path
export const SCOPE_NAME     = pkgJson.contributes.grammars[0]!.scopeName
export const EXTENSION_NAME = pkgJson.name
