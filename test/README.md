# Grammar tests

Test files are `make`/`Makefile` syntax files with a `.mk` file extension. They follow a _lab notebook_ style.

## Test runner

The test runner is implemented in [`runner/Makefile`](runner/Makefile). It should be invoked with the repo root as the current dir.

The default target is `test`. It is the only target intended to be requested by the user.

These shell commands are equivalent, except that the first also re-generates the grammar:
```sh
# invoke through repo-root's Makefile:
make test

# invoke through the test-runner Makefile directly:
make -f test/runner/Makefile
make -f test/runner/Makefile test
```

Environment variables can be used to select a subset of tests and to control the output. For details and defaults, see the [`runner/Makefile`](runner/Makefile) code.

The output is colorized if stdout is a terminal. To force colors, set `MAKE_TERMOUT=1`; to force no colors, set `NO_COLOR=1`.

### Invocation example

```sh
make test --keep-going TESTS=nest NOTRACE=1 VERBOSE=
```

The resulting test run:
- won't stop at the first test failure
- picks test files whose filename match `/.*nest.*/`
- won't print traces
- won't be verbose

## Test model

kind     |tests what?     |expected to|assertions from files
---      |---             |---        |---
**xpass**|grammar scoping |pass       |_not_ named `*.XFAIL.mk`
**xfail**|grammar scoping |fail       |named `*.XFAIL.mk`
**parse**|`make` behaviour|pass       |(all files)


### _xfail_ tests

These are suitable for assertions failing for a known reason, typically a known deficiency with the grammar.

An **xfail** test is a whole test file, with the expectation that _at least one_ of its grammar assertions fail. Therefore, _xfail_ test files should preferably test _at most one specific feature_ of the grammar.

If all grammar assertions in an _xfail_ test file unexpectedly pass, a warning is printed.

Any non-zero exit of `vscode-tmgrammar-test` is treated as an (expectedly) failing test.

### _parse_ tests

Full details + assertion syntax: see `parseTest --help` + the `parseTest` code.

Each test file with parse assertions asks _GNU `make`_ for the _`make` database_ (`make -p`) of the file and runs the parse assertions against it. Any error message or non-zero exit of `make -p` is ignored; whatever part of the `make` database is produced is still used. This is by design; it allows parse assertions in test files that also include syntax causing non-fatal `make` errors.

Any _parse test assertions_ in _xfail_ test files are _active_: it is a test failure if such an assertion fails.

_Warning_: requesting the make database might cause `make` to execute shell commands (e.g. `var != command`); prefer to avoid such syntax in the test files.

## Required system tools

- GNU `make` 4.4+
- `zsh`
- `pcre2grep`
- GNU `timeout` (optional; used if found)
- `vscode-tmgrammar-test`
  - install to expected location `node_modules/.bin/vscode-tmgrammar-test` with e.g. `pnpm install`, or set a custom path with `make test tmtest=..`

## Test output example

```sh
make -f test/runner/Makefile test TESTS=feat
```

Output:

```
[ok   parse]         feat-new.XFAIL.mk
[ok   parse]         main-feat.mk
[ok   parse]         other-feature.mk
[done parse] (n=3)

[exp  xfail]         feat-new.XFAIL.mk
[done xfail] (n=1)

[ok   xpass]         main-feat.mk
[ok   xpass]         other-feature.mk
[done      ] (n=2)
```
