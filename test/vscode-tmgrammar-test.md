# `vscode-tmgrammar-test`

## multiple scopes per assertion

```makefile
var := value
#      ^^^^^  meta.string.makefile string.unquoted.makefile
```

- passes if the token's scope stack has the scopes in the given order (outer -> inner), not necessarily adjacent
- scope names must match exactly (`meta.string` does not match `meta.string.makefile`)
- excluded scopes (`- scope`) are checked one by one, regardless of order

## tab characters

When aligning code with tab characters to ^ markers, the test engine will consider the tab character to be one (1) character. The following test file describes a test that will pass:
```bash
$ cat -t test.mk
# SYNTAX TEST "source.makefile"
target:
^I@echo
#^       keyword.control.recipe-lineprefix.makefile
# ^^^^ - keyword.control.recipe-lineprefix.makefile
```

## scope nesting order

nesting order of scopes for tokens getting multiple scopes:
- _can change_ how styling rules of a theme are applied -> can change visual appearance for users
- -> assert it (multi-scope assertion) only where it visibly matters with common themes; otherwise prefer single-scope assertions (more readable)

## `vscode-tmgrammar-test` may hang indefinitely with malformed scope specs

reason seems to be that the package uses an unfortunate regex that on mal-formed scope names can take exponential time

-> run with a timeout

## other

There might be relevant notes and/or reference material under `misc/notes/`.
