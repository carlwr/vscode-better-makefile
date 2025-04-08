# _Better Makefile_ VS Code extension

_Better syntax highlighting for makefiles_


## Development

### Set-up

```bash

# clone the repo:
git clone carlwr/vscode-better-makefile
cd vscode-better-makefile

# install dependencies:
pnpm install

```

### Building and testing

The textMate grammar is defined in _textMate YAML_. A build step converts the YAML file to the JSON textMate format that VS Code understands.

For building, testing and other dev-related tasks, either invoke the scripts in `package.json` or use the makefile. E.g. to build the JSON file, do:

```bash
make
# or
pnpm build
```

For details, see the mentioned files.

Run the grammar tests with:
```bash
make test
  # - runs xpass, xfail and parse tests
  # - supports verbosity and output formatting control (see Makefile)

# or

pnpm test
  # - only runs xpass tests
```
For the grammar tests, some of the files in `doc/dev/` are relevant.
