# Scope names — notes


line continuation character
* matches for Github search `path:/.*\.json/ "semanticTokenColors" <scope>`
  * 162 punctuation.separator.continuation
  *  11 constant.character.escape.continuation
  *  66 constant.character.escape.line-continuation
  *   0 punctuation.separator.line-continuation
* `jeff-hykin/better-shell-syntax`: constant.character.escape.line-continuation
* -> use all first three of above


variable name in variable assignment
* `variable.other.assignment.makefile`
* (follows jeff-hykin/better-shell-syntax)


built-in variables (= special variables)
* user may read and set (e.g. `MAKEFLAGS`)
  * -> decide to scope:
    * `variable.language.readwrite`
    * `variable.other.constant` (since styled peach by Catppuccin)
* user may read, not set (e.g. `CURDIR`)
  * -> decide to scope:
    * `variable.language.constant`
    * `constant.language` (since styled red by Catppuccin)
* themes
  * Catppuccin
    * `variable.other.constant` (peach)
    * `constant.language` (red)
  * VS Code Modern
    * `keyword.other.operator` (pink)
    * `variable.other.constant` (teal)
* guidelines
  * https://www.sublimetext.com/docs/scope_naming.html#variable


special targets (e.g. `.PHONY`)
* -> decide to scope:
  * `support.function.target.$1.makefile`
  * _and_ with the scopes used for built-in constants (that the user may only read, not set)


prereqs in rule head?
* currently, everything after ":": `meta.scope.prerequisites`
* SublimeText: `meta.function.arguments`
* other grammars: arguments in a function call?
  * most languages: no dedicated scopes
  * Python: `meta.function-call.arguments` (e.g. for "x, y" in `f(x, y)`)
* misc
  * Rust: `meta.function.call` (e.g. for "f(x)" in `z = f(x)`)


`%`
* Makefile syntax: used with similar meaning in
  * pattern rules
  * substitution references
  * more?
* -> decide to scope:
  * `constant.other.placeholder`
    * since: is how e.g. `%s` in printf format strings should be scoped, per https://www.sublimetext.com/docs/scope_naming.html#constant
  * `keyword.other.operator`, for VS Code
  * `variable.other.constant`, for Catppuccin (peach)


substitution references (`$(file:%.c=%.o)` etc.)
* :, =
  * -> decide to scope:
    * `keyword.operator.substref`
      * since: follows how `better-shell-syntax` scopes `##` in `${var##repl}` (scopes with `keyword.operator.expansion.shell`
    * `support.function.*` (styled well by VS Code)
    * `keyword.operator.*` (styled well by Catppuccin)
* %-s
  * -> see other bullet about `%` in general


file wildcards
* -> decide to scope:
  * `variable.language.special.wildcard` (since: precedent with `better-shell-syntax`)
  * VS Code Modern: `string.regexp` (since: is a scope that VS Code styles distinctively)


`meta.scope.target.makefile`
* use singular `.target.` rather than plural `.targets.`
  * since: `meta.scope.target.makefile` has prescedent in fadeevab/make.tmbundle


`$c`, `$(` + `)`
* -> decide to scope:
  * `$` in `$c` with `punctuation.section.embedded`
  * `$(` + `)` with `punctuation.definition.template-expression.{begin,end}`
  * since: presedence in several other grammars + styled by VS Code themes
  * (also scope all these with `punctuation.definition.variable`)
* other grammars
  * `jeff-hykin/better-shell-syntax`
    * scopes the whole `$v`, but just `var` in `$(var)`, with a `variable.*` scope
      * -> has consequences for how VS Code Modern styles these
  * Python
    * scopes brackets within string interpolation with `constant.character.format.placeholder.other`
      * VS Code Modern then styles due to `constant.character`
  * Ruby (and some other)
    * scopes `${` + `}`, or corresponding, in string interpolation with (Ruby:) `punctuation.section.embedded.begin.ruby`
      * -> VS Code modern styles this due to `punctuation.section.embedded`
  * TS
    * scopes `${` + `}` in interpolated strings with `punctuation.definition.template-expression.begin.ts` + `*.end.ts`
    * -> VS Code styles those scopes
* themes
  * VS Code `dark_vs.json`:
    ```json
    "name": "String interpolation",
    "scope": [
      "punctuation.definition.template-expression.begin",
      "punctuation.definition.template-expression.end",
      "punctuation.section.embedded"
    ],
    ```
  * Catppuccin
    * `punctuation` with `overlay2`
      * (no `punctuation.*` that is immediately applicable, and != text)
    * `punctuation.definition.variable` with `text`
      * -> I can't override this with some other scope that will win in specificity; accept that standard carppuccin will style this as text
    * `variable.parameter` with `maroon`
      * * (no `variable.*` that is immediately applicable, and != text)
    * `string.template variable` with `text`


## Links

VS Code stock themes scoping
* https://github.com/microsoft/vscode/blob/main/extensions/theme-defaults/themes/
  * inheritance: Dark 2026 -> Dark Modern -> Plus -> dark_vs

misc.
* https://github.com/tree-sitter-grammars/tree-sitter-make
  * https://github.com/tree-sitter-grammars/tree-sitter-make/blob/main/queries/highlights.scm
