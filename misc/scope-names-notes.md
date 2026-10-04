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
* `variable.language`
* user may read, not set
  * e.g. `MAKEFLAGS`
  * `variable.other.constant`, since an immutable variable
  * `variable.language.constant`, since immutable variables should get scope `variable.[*.]constant`
* user may read and set
  * e.g. `CURDIR`
  * `variable.language.readwrite`
* what some themes color
  * catppuccin: `variable.constant` (not `variable.language.constant`)
* ref's
  * https://www.sublimetext.com/docs/scope_naming.html#variable


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
* scope how?
  * -> should scope the way e.g. `%s` in printf format strings are usually scoped
    * -> `constant.other.placeholder`
      * ref.: https://www.sublimetext.com/docs/scope_naming.html#constant
* escaped %-s
  * `\%`


substitution references (`$(file:%.c=%.o)` etc.)
* :, =
  * -> scope the way shell expansions such as `${var##repl}` typ. scope `##`
    * better-shellsyntax uses `keyword.operator.expansion.shell`
  * -> `keyword.operator.substref`
* %-s
  * -> see other bullet about `%` in general


file wildcards
* `jeff-hykin/better-shell-syntax`
  * `variable.language.special.wildcard`


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
