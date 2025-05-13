
Package originally generated with: `npx --package yo --package generator-code -- yo code`

tmLanguage.json based on:
```
/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/extensions/make/syntaxes/make.tmLanguage.json
```

### Scope Names

* line continuation character
  * matches for Github search `path:/.*\.json/ "semanticTokenColors" <scope>`
    * 162 punctuation.separator.continuation
    *  11 constant.character.escape.continuation
    *  66 constant.character.escape.line-continuation
    *   0 punctuation.separator.line-continuation
  * `jeff-hykin/better-shell-syntax`: constant.character.escape.line-continuation
  * -> use all first three of above

* variable name in variable assignment
  * `variable.other.assignment.makefile`
  * (follows jeff-hykin/better-shell-syntax)

* built-in variables (= special variables)
  * `variable.language`
  * user may read, not set
    * e.g. `MAKEFLAGS`
    * `variable.other.constant`, since an immutable variable
    * `variable.language.constant`, since immutable variables should get scope `variable.[*.]constant`
  * user may read and set
    * e.g. `CURDIR`
    * `variable.language.readwrite`
  * ref's
    * https://www.sublimetext.com/docs/scope_naming.html#variable
