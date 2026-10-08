# Development

## Set-up locally + run tests

_Required system tools:_ Node.js, pnpm

```bash
git clone https://github.com/carlwr/vscode-better-makefile
cd vscode-better-makefile

pnpm install  # also enables the repo's git hooks
pnpm qa       # typecheck, lint, `pnpm test`
```

## Description

The TextMate grammar is defined in _TextMate YAML_. A build step uses it to generate two files under `syntaxes/`: the grammar as _TextMate JSON_ and a list of the scope names the grammar defines.

The generated files under `syntaxes/` are committed. Locally, a git hook helps with ensuring that the generated files reflect the source for each commit. CI checks that `main` commits are consistent.

## Development workflow

### Required system tools

`pnpm install` and `pnpm test`/`pnpm qa` require only Node.js and pnpm.

The git commit hook, `pnpm build` and the `make` targets additionally require:
- GNU `make` 4.4.1+
- `zsh`
- `jq`
- `pcre2grep`
- GNU `timeout` (optional; used by `make test` if found)

To install what is missing or too old:
```bash
brew install make jq pcre2 coreutils           # macOS
sudo apt-get install make zsh jq pcre2-utils   # Ubuntu 26.04+
```

`pnpm build` and the commit hook will run _GNU `make`_ as `gmake` if available, else as `make`.

### Build

Regenerate the files under `syntaxes/`:
```bash
make         # or, equivalent:
pnpm build
```

### Test

The grammar tests are run on the grammar as defined by _the generated TextMate JSON_ file.

`pnpm test`:
- does not re-generate the _TextMate JSON_ file
- runs the _xpass_ tests
- runs the language configuration test

`make test`:
- re-generates the `syntaxes/` files
- runs the _xpass_, _xfail_ and _parse_ tests
- pretty-prints the test progress
- supports verbosity/output formatting control and test filtering

More details: see [`test/README.md`](test/README.md)

## `git` and generated files

```bash
git commit                                  # git hooks are run
git commit -n                               # git hooks are bypassed
make gen && git add ./syntaxes              # re-gen on `syntaxes/` conflicts
git rebase -x './scripts/make check' <base> # verify a range
git diff -- ':!syntaxes/'                   # diff, excluding generated files

# to bisect:
git bisect run sh -c 'grep -q ^check: Makefile || exit 125; make check'
```

## Other useful commands

```bash
pnpm run prepare  # set up git hooks for an existing checkout
make check        # verify that `syntaxes/` is up to date

# print the scope names the grammar defines to stdout:
./scripts/scopes syntaxes/makefile.tmLanguage.json

# print lines including "myVar" in the make database of `<file>.mk`:
make -nps -f <file>.mk|grep myVar|cat -e|sort|less

# possibly useful to print a partial ref on GNU `make` syntax:
info --node 'quick' make | grep -Po "(?x) (?<=^') .* (?='$)" | less
```

## Auto-reload window convenience

With the [`auto-reload-window` extension][arw-ext], it is possible to see updated highlighting immediately and automatically when the yaml grammar file is saved:
* run the background _watch_ task in `.vscode/tasks.json` to automatically trigger the yaml to json conversion on save
* use the launch task in `.vscode/launch.json` to open a _development host_ window running this (=the language grammar) extension
  * this launch task also sets environment variables for `auto-reload-window`
* if `auto-reload-window` is installed, it will pick up the settings in `.vscode/settings.json`

The consequence of the above taken together is that saving the yaml grammar will immediately show files in the _development host window_ with updated highlighting, whereas other windows will not be affected or automatically reloaded.

[arw-ext]: https://marketplace.visualstudio.com/items?itemName=carlwr.auto-reload-window


## Ref's

* https://github.com/microsoft/vscode-textmate/blob/main/src/rule.ts
* https://github.com/microsoft/vscode-textmate/blob/main/src/rawGrammar.ts
* https://github.com/microsoft/vscode-grammar-updater
