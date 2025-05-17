import { pkgJson } from './pkgJson.js';

export const TMATE_SCHEMA   = 'schemas/tmLanguage.schema.json'
export const GRAMMAR_YAML   = 'src/makefile.tmLanguage.yaml'
export const GRAMMAR_JSON   = pkgJson.contributes.grammars[0].path
export const SCOPE_NAME     = pkgJson.contributes.grammars[0].scopeName
export const EXTENSION_NAME = pkgJson.name
