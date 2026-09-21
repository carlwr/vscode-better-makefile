<h2 align="center">
	<img src="https://raw.githubusercontent.com/carlwr/vscode-better-makefile/main/misc/icon_128.png" width="128" alt="Icon"/><br/><br/>
	Better Makefile<br/><br/>
</h2>

<p align="center">
  <i>improved syntax highlighting of makefiles in <b>VS Code</b></i><br/><br/>
</p>

<div align="center">

[![ci](https://img.shields.io/github/actions/workflow/status/carlwr/vscode-better-makefile/ci.yml?branch=main&logo=github&label=ci)](https://github.com/carlwr/vscode-better-makefile/actions/workflows/ci.yml)
[![marketplace](https://img.shields.io/badge/marketplace-VS_Code-blue)](https://marketplace.visualstudio.com/items?itemName=carlwr.better-makefile)
[![open vsx](https://img.shields.io/badge/marketplace-Open_VSX-blue)](https://open-vsx.org/extension/carlwr/better-makefile)
[![release](https://img.shields.io/github/v/release/carlwr/vscode-better-makefile?logo=github)](https://github.com/carlwr/vscode-better-makefile/releases)
[![license](https://img.shields.io/badge/license-MIT-green)](https://github.com/carlwr/vscode-better-makefile/blob/main/LICENSE)

</div>

<br/><br/>


Intended audience: anyone reading or writing makefiles in _VS Code_.

&nbsp;

## How to use

Just install the extension - no other action is needed; _VS Code_ will automatically use the extension for all makefiles.

&nbsp;

## Improvements

Improvements vs. the default _VS Code_ treatment of makefiles include:

**Syntax support:**
- correctly highlights commonly used syntax that the default _VS Code_ grammar does not, e.g.
  - assignment operators `::=`, `!=`
  - rulehead separators `&:`, `::`
  - substitution references (`$(src:%.c=%.o)`)
  - parenthesized automatic variables (`$(@D)`, `$(@F)`, `$(@)`)
  - static-pattern rules (`a.o b.o: %.o: %.c`)
  - wildcard chars in ruleheads (`*.o: common.h`)
  - target-specific assignments (`main: CFLAGS = -g`)
  - single-line rules (`t: p; recipe`)
  - escape and escaped characters, depending on syntax context
- does not highlight invalid syntax as valid in some cases where the default _VS Code_ grammar incorrectly does, making errors easier to spot
  - e.g. `$(SHELL )`, `$((SHELL))` (_GNU `make`_ does not expand those to the intended special variables, but the default _VS Code_ grammar highlights as if they do)
- avoids a number of bugs in the default grammar — for example, this grammar:
  - correctly scopes rules and variable assignments that start with an expansion (`$(objs): common.h`)
  - correctly scopes ruleheads with line continuation before the rulehead separator
  - `:`s and `=`s in substitution references are not mistaken for rulehead separators or assignment operators
  - a `:` in a comment does not mistake the line for a rulehead (`not  # a : rulehead`)

**Robustness:**
- unconditionally ends scopes on non-escaped newlines which avoids runaway highlighting for makefiles with incorrect syntax (and in case of bugs in the grammar of this extension)
- provides _multiple_ scopes to syntax elements where appropriate, increasing the likelihood that themes provide appropriate highlighting
- thorough automatic tests, including verification against _GNU `make`_'s parsing of the test file to ensure the grammar and _GNU `make`_ agree

**General:**
- is updated with the latest _GNU `make`_ 4.4.1 syntax (e.g. available special targets, special variables, built-in functions)
- defines `$(...)` and `${...}` as bracket pairs so _VS Code_ can match and highlight them properly

&nbsp;

## Where to get it

This extension is available through:
- [the _VS Code_ marketplace](https://marketplace.visualstudio.com/items?itemName=carlwr.better-makefile)
- [open-vsx.org](https://open-vsx.org/extension/carlwr/better-makefile)
- [GitHub releases](https://github.com/carlwr/vscode-better-makefile/releases) (`.vsix` file)

&nbsp;

## Choice of highlighting theme

This extension will improve the highlighting of makefiles regardless of the theme used.

Note however that the default _VS Code_ themes are rather limited in what scopes they highlight. To benefit fully from the improved grammar, use a theme that highlights more ambitiously, e.g.
- Catppuccin ([marketplace](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc), [open-vsx.org](https://open-vsx.org/extension/Catppuccin/catppuccin-vsc))
- XD Theme ([marketplace](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.xd-theme), [open-vsx.org](https://open-vsx.org/extension/jeff-hykin/xd-theme))

&nbsp;

## Design choices

- no shell syntax highlighting within recipes
  - since we prefer to keep recipes visually distinct from the other parts of the file, improving readability of the file as a whole
- no support for custom `.RECIPEPREFIX`, i.e. for makefiles that don't use `<tab>` (the default) as the recipe prefix
  - since it's hard or impossible to detect and react to (given the limitations of the TextMate grammar format that _VS Code_ uses)
  - since unconditionally including `" "` (whitespace character) as a recipe prefix for all files would make the scoping/highlighting less robust
- does not scope anything as syntax errors
  - since it would cause e.g. makefiles for BSD-flavoured `make`s to highlight valid syntax as invalid

&nbsp;

## Supported `make` flavours

The extension is targeted at and tested against _GNU `make` 4.4.1_ and supports most of its syntax and all of its built-in identifiers.

The extension highlights the makefile syntax of any earlier _GNU `make`_ and any [_POSIX `make`_][posix-make] almost as well. It does a reasonable job with _BSD_ flavours (`pmake`, `bmake`, `fmake`) and _Microsoft `make`_ (`nmake`).

&nbsp;

## Reporting issues

Grammar bugs can be reported in the [GitHub issues][gh-issues].

&nbsp;

## For theme authors

The scopes this extension defines are listed in [`syntaxes/makefile.scopes.txt`](syntaxes/makefile.scopes.txt), also included with each [release][gh-releases].

&nbsp;

## For downstream _grammar_ users

The JSON TextMate grammar itself is available as:
- a file committed at [`syntaxes/makefile.tmLanguage.json`](syntaxes/makefile.tmLanguage.json) - that repo path will remain stable on `main`
- a [GitHub release][gh-releases] asset

The JSON grammar is generated from a YAML source. Git hooks (committed) make sure all commits have a freshly generated JSON grammar, and [CI](.github/workflows) verifies the two match.

The JSON grammar:
- conforms to the [public TextMate schema][tm-schema]
- uses only regexes that:
  - are valid [_Oniguruma_][oniguruma] regexes
    - as per [vscode-oniguruma], verified with [@carlwr/textmate-validate]

The above is verified at build time and in CI.

&nbsp;

## Created by a human

This `README.md` is authored entirely by me (Carl), a human developer; AI tools [were not allowed][AGENTS.md] to author text or suggest phrasing in it.

The grammar itself was hand-rolled by me; so were the extensive tests and the testing set-up<sup>[1]</sup>. The majority of the work was done early 2025; experiments with the latest agentic tooling and models at that time still could not speed up the work compared with me hand-coding everything myself.

Post the 1.0 release (spring 2026) agentic tooling might be used for improvements and edits. This `README.md` file, however, remains [fully human-authored][AGENTS.md].

---

<sup>[1]</sup>: The [test runner used in this project](./Makefile) could be characterized as maybe _"a small custom-made test runner implemented in GNU make"_. It is quite unconventional but it does, I must say, serve its purpose reasonably well. Writing it as a Makefile allowed me to express it concisely and declaratively.


<!----- links ----->

[AGENTS.md]: ./AGENTS.md
[gh-releases]: https://github.com/carlwr/vscode-better-makefile/releases
[gh-issues]: https://github.com/carlwr/vscode-better-makefile/issues
[@carlwr/textmate-validate]: https://www.npmjs.com/package/@carlwr/textmate-validate
[gh-textmate-validate]: https://github.com/carlwr/textmate-validate
[tm-schema]: https://json.schemastore.org/tmlanguage.json
[vscode-oniguruma]: https://github.com/microsoft/vscode-oniguruma
[posix-make]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/make.html
[oniguruma]: https://github.com/kkos/oniguruma

<!-- note: relative repo links should be fine; `vsce` re-writes them to absolute using the `repository` field; and Open VSX receives that re-written README -->
