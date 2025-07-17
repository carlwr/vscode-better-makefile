<h2 align="center">
	<img src="https://raw.githubusercontent.com/carlwr/vscode-better-makefile/main/misc/icon_128.png" width="128" alt="Icon"/><br/><br/>
	Better Makefile<br/><br/>
</h2>

<p align="center">
  <i>improved syntax highlighting of Makefiles in VS Code</i><br/><br/>
</p>

<p align="center">
  <a href="https://marketplace.visualstudio.com/items?itemName=carlwr.better-makefile">
    <img alt="VS Code Marketplace" src="https://img.shields.io/visual-studio-marketplace/release-date/carlwr.better-makefile?style=for-the-badge&label=VS-Code">
  </a>
  <a href="https://open-vsx.org/extension/carlwr/better-makefile">
    <img alt="Open VSX" src="https://img.shields.io/open-vsx/release-date/carlwr/vscode-better-makefile?style=for-the-badge&label=open-vsx">
  </a>
  <a href="https://github.com/carlwr/vscode-better-makefile/releases">
    <img alt="GitHub" src="https://img.shields.io/github/v/release/carlwr/vscode-better-makefile?style=for-the-badge&logo=github">
  </a>
</p>

<br/><br/>


Intended audience: anyone reading or writing Makefiles in VS Code.

&nbsp;

## How to use

Just install the extension - no other action is needed; VS Code will automatically use the extension for all Makefile files.

&nbsp;

## Improvements

Improvements vs. the default VS Code treatment of Makefile files include:

**Syntax support:**
- correctly highlights commonly used Makefile syntax that the default VS Code grammar does not, e.g.
  - assignment operators `::=`, `!=`
  - rulehead separators `&:`, `::`
  - substitution references (`$(src:%.c=%.o)`)
  - parenthesized automatic variables (`$(@D)`, `$(@F)`, `$(@)`)
  - static-pattern rules (`a.o b.o: %.o: %.c`)
  - wildcard chars in ruleheads (`*.o: common.h`)
  - target-specific assignments (`main: CFLAGS = -g`)
  - single-line rules (`t: p; recipe`)
  - escape and escaped characters, depending on syntax context
- does not highlight invalid syntax as valid in some cases where the default VS Code grammar incorrectly does, making errors easier to spot
  - e.g. `$(SHELL )`, `$((SHELL))` (invalid GNU make syntax, yet highlighted as valid by the default VS Code grammar)
- avoids a number of bugs in the default grammar, e.g.
  - correctly scopes rules and variable assignments that start with an expansion (`$(objs): common.h`)
  - correctly scopes ruleheads with line continuation before the rulehead separator
  - `:`s and `=`s in substitution references are not mistaken for rulehead separators or assignment operators
  - a `:` in a comment does not mistake the line for a rulehead (`not  # a : rulehead`)

**Robustness:**
- unconditionally ends scopes on non-escaped newlines which avoids runaway highlighting for makefiles with incorrect syntax (and in case of bugs in the grammar of this extension)
- provides _multiple_ scopes to syntax elements where appropriate, increasing the likelihood that themes provide appropriate highlighting
- thorough automatic tests, including verification against GNU make's parsing of the test file to ensure the grammar and GNU make agree

**General:**
- is updated with the latest GNU make 4.4.1 syntax (e.g. available special targets, special variables, built-in functions)
- defines `$(...)` and `${...}` as bracket pairs so VS Code can match and highlight them properly

&nbsp;

## Makefile syntax variants

The extension is targeted at and tested against _GNU make 4.4.1_ and supports most of its syntax and all of its built-in identifiers.

The extension highlights Makefile syntax of any earlier GNU Make and any POSIX Make almost as well. It does a reasonable job with BSD flavours (`pmake`, `bmake`, `fmake`) and Microsoft Make (`nmake`).

&nbsp;

## Choice of highlighting theme

This extension will improve the highlighting of makefiles regardless of the theme used.

Note however that the default VS Code themes are rather limited in what scopes they highlight. To benefit fully from the richer scoping, use a theme that highlights more ambitiously, e.g.
- Catppuccin ([marketplace](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc), [open-vsx.org](https://open-vsx.org/extension/Catppuccin/catppuccin-vsc))
- XD Theme ([marketplace](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.xd-theme), [open-vsx.org](https://open-vsx.org/extension/jeff-hykin/xd-theme))

&nbsp;

## Design choices

- no shell syntax highlighting within recipes
  - since we prefer to keep recipes visually distinct from the other parts of the makefile, improving readability of the makefile as a whole
- no support for custom `.RECIPEPREFIX`, i.e. for makefiles that don't use `<tab>` (the default) as the recipe prefix
  - since it's hard or impossible to detect and react to (given the limitations of the textMate grammar format that VS Code uses)
  - since treating e.g. `whitespace` as a recipe prefix for all makefiles would make the scoping/highlighting less robust

&nbsp;

## Where to get it

This extension is available through:
- [the VS Code marketplace](https://marketplace.visualstudio.com/items?itemName=carlwr.better-makefile)
- [open-vsx.org](https://open-vsx.org/extension/carlwr/better-makefile)
- [GitHub releases](https://github.com/carlwr/vscode-better-makefile/releases) (`.vsix` file)

&nbsp;

## Reporting issues

Grammar bugs can be reported in the [GitHub issues](https://github.com/carlwr/vscode-better-makefile/issues).

&nbsp;

## For theme authors

The scopes this extension defines are available in the `makefile.scopes.txt` file which is generated and included with each [release](https://github.com/carlwr/vscode-better-makefile/releases).
