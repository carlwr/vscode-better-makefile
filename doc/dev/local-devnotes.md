
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

* prereqs in rule head?
  * currently, everything after ":": `meta.scope.prerequisites`
  * SublimeText: `meta.function.arguments`
  * other grammars: arguments in a function call?
    * most languages: no dedicated scopes
    * Python: `meta.function-call.arguments` (e.g. for "x, y" in `f(x, y)`)
  * misc
    * Rust: `meta.function.call` (e.g. for "f(x)" in `z = f(x)`)

* `%`
  * Makefile syntax: used with similar meaning in
    * pattern rules
    * substitution references
    * more?
  * scope how?
    * -> should scope the way e.g. `%s` in printf format strings are usually scoped
      * -> `constant.other.placeholder`
        * ref.: https://www.sublimetext.com/docs/scope_naming.html#constant
  * escaped %-s
    * `\%`

* substitution references (`$(file:%.c=%.o)` etc.)
  * :, =
    * -> scope the way shell expansions such as `${var##repl}` typ. scope `##`
      * better-shellsyntax uses `keyword.operator.expansion.shell`
    * -> `keyword.operator.substref`
  * %-s
    * -> see other bullet about `%` in general

file wildcards
  * `jeff-hykin/better-shell-syntax`
    * `variable.language.special.wildcard`
