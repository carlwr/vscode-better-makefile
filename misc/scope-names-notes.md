# Scope names — notes

## conventions

If multiple scopes are listed as bullets, e.g. as a "decide to scope as" list, the order of the bullets is the same as the order of the scopes in the grammar rule.

### example

this scope list:
* `scopeA`
  * ...
* `scopeB`
  * ...

...corresponds to a grammar resulting in, as JSON:

```json
"name": "scopeA scopeB"
```

## general notes

line continuation character
* matches for Github search `path:/.*\.json/ "semanticTokenColors" <scope>`
  * 162 punctuation.separator.continuation
  *  11 constant.character.escape.continuation
  *  66 constant.character.escape.line-continuation
  *   0 punctuation.separator.line-continuation
* `better-shell-syntax`: constant.character.escape.line-continuation
* -> use all first three of above
  * order: escapes last -> Catppuccin: escape color, not punctuation color


variable name in variable assignment
* -> decide to scope:
  * `variable.other.assignment.makefile`
    * note: precedent in `better-shell-syntax`
  * _don't_ scope with `entity.name.variable`
    * since:
      * neither TS, JS or C# grammars scope with it at declaration site/assignment position
      * would give unfortunate results with VSCode-2026: would be styled with a color similar to that of `string` -> `var := value` would have its LHS and RHS styled with similar colors
  * note: `var=value` is scoped exactly the same in a Makefile with this grammar as in a shellscript with `better-shell-syntax` (except this grammar also adding `meta.string.makefile` on RHS, per Sublimetext guidelines)
* themes
  * `entity.name.variable`
    * VSCode-Plus: does style it (teal); from its style rule context, it seems intended for variable _declaration_ sites
* other language grammars
  * none of TS, JS or C# grammars seem to scope variables at declaration site/assignment position with `entity.name.variable`
* guidelines
  * Sublimetext:
    * `entity.name.function` (only) where declared
    * `variable.function` (only) where invoked
    * (does not mention any `entity.name.variable` scope)


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


automatic variables
* -> decide to scope:
  * `variable.parameter.automatic.makefile`
    * since:
      * is most similar to how common grammars (TS, JS, C#) scopes referenced function parameters (=~ automatic vars, semantically)
      * is styled distinctive orange with VSCode-2026
    * further notes + reasoning:
      * as a consequence, VSCode-Modern will style with teal, the same as user vars)
      * difference `make.tmbundle` -> this grammar, in VS Code:
        * mid-blue -> orange (VSCode-2026)
        * mid-blue -> teal (all themes up to -Modern)
      * note: not possible for this grammar to stack `variable.parameter` and `variable.language` in a way so that -Modern retains mid-blue while -2026 gets orange
      * -> prefer to scope with `variable.parameter` only; for VSCode-2026 that gives styling most consistent with other major languages grammars, and buys the distinct orange (tolerate the necessary _slight_ regression for VSCode-Modern)
* reasoning about semantic meaning
  * an _automatic variable_ seems most similar to a _referenced function parameter_ (that `make` passed into recipes implicitly)
* other language grammars
  * `make.tmbundle`
    * `variable.language` -> VSCode themes style with mid-blue
  * TS, JS, C#
    * scopes referenced function parameters as `variable.parameter` (through semantic tokens)
      * -> With VSCode-2026 referenced params get the distinct orange color
* themes
  * VS Code:
    * `variable.parameter`: not styled by any theme (-> get styled by `variable`)
    * `variable.parameter.function`: teal in -2026 (not styled by other themes)
    * `variable.language`: mid-blue in all themes
    * `variable`: teal up to -Modern, orange in -2026
* guidelines
  * Sublimetext
    * > Reserved variable names that are specified by the language, such as this, self, super, etc. should use `variable.language`
    * > Parameters to a function or methods should use the [`variable.parameter`]. [It] may also be used for other parameter-like variables, such as receivers or named return values in Go.


positional variables
* -> decide to scope:
  * like _automatic_ variables, but `/automatic/` -> `/positional/`
* note: semantically similar to _automatic variables_ ("implicitly passed function arguments"); see notes on _automatic variables_


special targets (e.g. `.PHONY`)
* -> decide to scope:
  * `support.function.target.$1.makefile`
    * since: that's what `make.tmbundle` does (-> yellow in VSCode-Modern/2026)
    * note: -> special targets styled distinct from user targets with VSCode-2026 but not with VSCode-Modern
* considered and rejected: adding also `support.type.target.$1.makefile`
  * for: would make user<->special targets distinct also with VSCode-Modern
  * against: would be a stretch semantically; would introduce a visual difference vs. `make.tmbundle`; wouldn't add visual benefit in the most important theme (VSCode-2026)
* themes
  * VSCode-Modern, VSCode-2026
    * `support.type`: green-teal
  * VSCode
    * `entity.other.attribute` styled green-teal
  * Catppuccin
    * `support.type`: yellow + italic


prereqs in rule head:
* -> decide:
  * `meta.scope.prerequisites`
  * (don't scope with any "function argument"-like scope, even though SublimeText's Makefile grammar does)
* other Makefile grammars
  * SublimeText: `meta.function.arguments.makefile`


targets
* -> decide to scope:
  * `entity.name.function.target.makefile`
    * since: has precedent in `make.tmbundle`
  * meta-scope
    * `meta.scope.target.makefile`
      * since: has precedent in `make.tmbundle`
      * note: use singular `.target.` rather than plural `.targets.`


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
      * since: follows how `better-shell-syntax` scopes `##` in `${var##repl}` (scopes with `keyword.operator.expansion.shell`)
    * `support.function.*` (styled well by VS Code)
    * `keyword.operator.*` (styled well by Catppuccin)
* %-s
  * -> see other bullet about `%` in general


file wildcards
* -> decide to scope:
  * `variable.language.special.wildcard` (since: precedent with `better-shell-syntax`)
  * VS Code Modern: `string.regexp` (since: is a scope that VS Code styles distinctively)


`$c`, `$(` + `)`
* -> decide to scope:
  * w.r.t. punctuation scopes
    * `$(` + `)` with `punctuation.definition.template-expression.{begin,end}`
    * since: precedent in several other grammars + styled by VS Code themes
    * (also scope all these with `punctuation.definition.variable`)
  * w.r.t. variable name scope
    * -> scope `$c` as a whole, but only `name` in `$(name)`
* other grammars
  * `better-shell-syntax`
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
      * -> I can't override this with some other scope that will win in specificity; accept that standard Catppuccin will style this as text
    * `variable.parameter` with `maroon`
      * (no `variable.*` that is immediately applicable, and != text)
    * `string.template variable` with `text`


function calls/invocation meta-scope (at call sites)
* -> decide
  * `meta.function-call.makefile`
    * since: more standard than the alternative `meta.scope.function-call.makefile`
* other language grammars:
  * most languages: no dedicated scopes
  * `meta.scope.function-call.makefile` used in `fadeevab/make.tmbundle`
  * `meta.function.call.rust` (e.g. for "f(x)" in `z = f(x)`)
  * `meta.function-call.ruby`
* themes
  * VS Code: styles no `/function.call/` scope or `meta.` scope
  * Catppuccin: styles no `/function.call/` scope or `meta.` scope
* guidelines
  * Sublimetext:
    * `entity.name.function` (only) where declared
    * `variable.function` (only) where invoked
    * (says nothing about meta scopes at function call sites either way)


* function arguments (at call sites)
  * -> decide:
    * string scopes + `meta.function-call.arguments.makefile`
    * string scope only for all valid chars, including e g `*`, `=`, `:`
      * since: mentioned chars are special only for _some_ functions; prefer string scope so e.g. `$(info [DEBUG] q = 100%)` gets an unbroken string scope for the whole argument
  * other grammars:
    * (most grammars: no scope; exceptions:)
    * `meta.arguments.coffeescript`
    * `meta.function-call.arguments.python`
    * `meta.function-call.arguments.r`
  * guidelines:
    * Sublimetext guidelines: says nothing


strings
* what to scope with _string_ scopes?
  * -> decide:
    - those ranges that we can reliably know to be strings: RHS of assignments (including define)
    - function args
    - relevant parts of substref-s
  * since:
    * function args: keeps `fadeevab/make.tmbundle`'s look
    * precedents
      * RHS as string: SublimeText (-> `bat`), KDE/Kate, KDevelop
      * RHS incl. define bodies + function args: Helix, Zed, JetBrains
      * VS Code's own shell grammar: `FOO=bar`, `echo foo` -> `string.unquoted.*`
    * `string.unquoted`: TextMate convention says "for things like here-docs" (cf. define bodies)
  * no `string.interpolated`
    * since: TextMate meaning is "evaluated" strings (`date`, $(pwd)); stock uses it for expansions, not values; no theme styles it generically
* other Makefile grammars
  * SublimeText's Makefile grammar
    * assignment RHS + define bodies: `meta.string string.unquoted` (since 2015)
      * except `!=` RHS: `source.shell.embedded`
      * also strings: include args, vpath dirs, prereqs
      * not strings: function args, substref-s
      * expansions within strings keep the string scope (contrary to own guideline)
* guidelines
  * https://www.sublimetext.com/docs/scope_naming.html#string: strings should have `string.unquoted` and `meta.string`
    * `meta.string` spans whole string incl. interpolations; `string.*` cleared within interpolations (`meta.interpolation`)
* editor behaviour (VS Code) for string tokens
  * brackets ignored for matching + colorization -> intended: bare brackets in values are not syntax
    * `$(`, `)` must stay outside string scopes (else: VS Code issue #38078); `meta.string` too counts as string
  * quick suggestions off by default -> re-enabled for makefile, with the default for code (cf. VS Code's yaml, dockerfile)
  * quotes auto-close unless `notIn` -> `notIn` comment only (effectively as stock)


## Deliberately not done

_more fine-grained scoping for some functions_:
- e.g.:
  - `$(foreach varname, ..)`
  - `$(call funcvar, ..)`
  - `$(let a b,x y)`
  - (maybe others)
- skip since: considered too much work / considered to make the YAML grammar too complicated vs. what user value it would add


## scope prefix `meta.scope.X` vs. `meta.X`

-> decided:
* prefer `meta.scope.X` where there is precedent in `make.tmbundle`, and possibly for other meta scopes this grammar introduces
* prefer `meta.X` for `X` when `meta.X` is established (e.g. through other language grammars, themes etc.)

other grammars:
* `meta.scope.X`
  * is what `make.tmbundle` uses consistently for `meta.` scopes
* `meta.X`
  * is what most (other) language grammars use

themes:
* VS Code, Catppuccin styles no `meta.scope.X` scopes (but a few `meta.X` scopes)

guidelines
* https://www.sublimetext.com/docs/scope_naming.html: mentions only `meta.X` scopes, no `meta.scope.X` scopes


## resulting scope stack w.r.t. `meta.` scopes

Prefer to scope so that any `meta.` are on lower layers in the resulting scope stack than the main non-`meta.` scopes.
* since:
  * guarantees that `meta.` scopes will work robustly as qualifiers (e.g. `"meta.function-call variable.language"`) in rules of themes using the grammar
  * (minor:) listed/displayed scope stacks produced by the grammar are more intuitive and readable


## multiple scopes for one token

I.e. for tokens that match a grammar rule that has e.g.:
```json
"name": "scopeA scopeB"
```

VS Code (`vscode-textmate`) behaviour:
* splits on single spaces; pushes each as a nested scope, in order (last = innermost)
* theme styling: later scope overrides earlier, per attribute (e.g. color from `scopeB`, italic kept from `scopeA`)
  * regardless of theme rule specificity
  * a scope no theme rule matches overrides nothing

-> decided (guidelines):
* treat scope lists as an ordered fallback chain:
  * first: most generic/most widely styled
  * last: preferred
* put `meta.` scopes first (so `meta.X foo` theme selectors match)


## Deliberately not done

_more fine-grained scoping for some functions_:
- e.g.:
  - `$(foreach varname, ..)`
  - `$(value varname)`
  - `$(call funcvar, ..)`
  - `$(let a b,x y)`
  - (maybe others)
  - (there might be XFAIL tests for some of the above)
- skip since: considered too much work / considered to make the YAML grammar too complicated vs. what user value it would add


## other grammars

`make.tmbundle`
* when referenced, refers to https://github.com/fadeevab/make.tmbundle
* currently the upstream of VS Code's Makefile grammar
* fork of https://github.com/textmate/make.tmbundle

`better-shell-syntax`
* https://github.com/jeff-hykin/better-shell-syntax
* currently the upstream of VS Code's shellscript grammar

`tree-sitter-make`
* https://github.com/tree-sitter-grammars/tree-sitter-make
* https://github.com/tree-sitter-grammars/tree-sitter-make/blob/main/queries/highlights.scm


## Links

VS Code stock themes scoping
* https://github.com/microsoft/vscode/blob/main/extensions/theme-defaults/themes/
  * inheritance: Dark 2026 -> Dark Modern -> Plus -> dark_vs

Github Linguist's TextMate theme (deprecated 2025)
* https://github.com/primer/github-textmate-theme/blob/master/GitHub%20Dark.tmTheme
* https://github.com/primer/github-syntax-theme-generator/blob/main/lib/themes/dark.json

misc.
* https://github.com/github-linguist/linguist
