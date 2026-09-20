## Print scope names

To print the scope names the grammar defines to stdout, run:
```bash
./scripts/scopes syntaxes/makefile.tmLanguage.json
```

## Development

### Set-up

Clone and install deps:
```bash
git clone carlwr/vscode-better-makefile
cd vscode-better-makefile
pnpm install
```

### Build

The textMate grammar is defined in _textMate YAML_. A build step converts the YAML file to the JSON textMate format that VS Code understands.
```bash
make
  # - typecheck + lint, then `make gen` (regenerates `syntaxes/`)
# -- or --
pnpm build

make check
  # - verifies that `syntaxes/` is up to date; never writes to it
```

System tools required by `make` (any target; hence also by `pnpm build` - but not by `pnpm install` or `pnpm test`):
- GNU make 4.4+
- zsh
- jq
- pcre2grep

To install what is missing or too old on:
```bash
# macOS (GNU make is installed as `gmake`):
brew install make jq pcre2

# Ubuntu (26.04+; the `make` of earlier releases is too old):
sudo apt-get install make zsh jq pcre2-utils
```

### Generated files

Files under `syntaxes/`:
- are generated from `src/makefile.tmLanguage.yaml`
- are committed
- should match the source; this is:
  - verified locally with `make check`

```bash
make gen && git add syntaxes      # re-generate on conflicts under `syntaxes/`
git rebase -x 'make check' <base> # verify a range
git diff -- ':!syntaxes/'         # diff, excluding the generated files

# to bisect:
git bisect run sh -c 'grep -q ^check: Makefile || exit 125; make check'
```

### Run tests

```bash
make test
  # - runs xpass, xfail and parse tests
  # - supports verbosity and output formatting control (see Makefile)

# -- or --

pnpm test
  # - only runs xpass tests
```

For the grammar tests, some of the files in `doc/dev/` are relevant.

### Auto-reload window convenience

With the [`auto-reload-window` extension][arw-ext], it is possible to see updated highlighting immediately and automatically when the yaml grammar file is saved:
* run the background _watch_ task in `.vscode/tasks.json` to automatically trigger the yaml to json conversion on save
* use the launch task in `.vscode/launch.json` to open a _development host_ window running this (=the language grammar) extension
  * this launch tasks also sets environment variables for `auto-reload-window`
* if `auto-reload-window` is installed, it will pick up the settings in `.vscode/settings.json`

The consequence of the above taken together is that saving the yaml grammar will immediately show files in the _development host window_ with updated highlighting, whereas other windows will not be affected or automatically reloaded.

[arw-gh]: https://github.com/carlwr/vscode-auto-reload-window
[arw-ext]: https://marketplace.visualstudio.com/items?itemName=carlwr.auto-reload-window


## Ref's

* https://github.com/microsoft/vscode-textmate/blob/main/src/rule.ts
* https://github.com/microsoft/vscode-textmate/blob/main/src/rawGrammar.ts
* https://github.com/microsoft/vscode-grammar-updater
* https://github.com/fadeevab/make.tmbundle
  * fork of https://github.com/textmate/make.tmbundle

Possibly useful to print a partial ref on GNU make syntax:
```bash
info --node 'quick' make | grep -Po "(?x) (?<=^') .* (?='$)" | less
