# running tests

command `make test` will
* (if needed) convert the .yaml grammar to .json format
* run all tests, namely all files `test/grammar/*.mk`:
  * `test/grammar/*.XFAIL.mk`: expected to fail (prints warning if passing)
  * all other: normal test; expected to pass

xfail test files:
* are suitable for tests failing for a known reason, typically a known deficiency with the grammar
* should have tests for _one specific feature of the grammar_
  * since: the tests only report/detect one of two possible states for an XFAIL test file: 1.) at least one of the tests in the file failed, 2.) _all_ tests in the file _pass_
  * -> if needed, divide xfail tests into separate files; use a suitable qualifying name (e.g. `assign.doubleColon.XFAIL.mk`) or even just a running counter (`assign.01.XFAIL.mk`)


# test file syntax

example test file with comments on the test file syntax in `<angle brackets>`:
```makefile
# SYNTAX TEST "source.makefile"
# <above: required first line!>

include $(inc)
#^^^^^^          keyword.control.include.makefile

# <above: there are ^-s at columns 2-7, followed by an arbitrary amount of whitespace, followed by the name of a scope: this test will pass if that scope is indeed the grammar-specified scope at columns 2-7 on the line `include foo.mk`.>

#         ^^^    variable.other.makefile

# <the line above specifies another test for the same line: lines with ^-s and scope names _apply to the closest non-commented line above it_. Hence, the line above will be a passing test iff columns 11, 12 and 13 for the line "include $(inc)" - i.e. the string "inc" on that line, are scoped with `variable.other.makefile`.>


v = $(SHELL)str$(SHELL)
#           ^^^         - variable.language.readwrite.makefile
# <above: the ^-s point out where the scope must NOT apply: scope name preceded with "-">

# any comments, like this one, may also be in the test file

# to test the leftmost character/column, use "<-":
$(SHELL): lessBadBash.c
#<- entity.name.function.target.makefile

# the following tests that both "%" characters are scoped correctly:
%.c: %.o
#<-      constant.other.placeholder.makefile
#    ^   constant.other.placeholder.makefile

```

## tab characters

When aligning code with tab characters to ^ markers, the test engine will consider the tab character to be one (1) character - the following test file describes a test that will pass:
```bash
$ cat -t test.mk
# SYNTAX TEST "source.makefile"
target:
^Iecho
#<-      keyword.control.recipe-lineprefix.makefile
#^^^^  - keyword.control.recipe-lineprefix.makefile
```

## final newline

All files in the repo, including test files, should have a final newline.


# test file style guide

* at most one scope name per line
* vertically-align scope names (possibly not for the full file, but for subsections of the test file)
* keep active lines _short_
* use section headers where appropriate [1]
* vary the contents on the active lines [1]

example - some comments on the styling within `<angle brackets>`:
```makefile

# variable expansion on assignment RHS
# ------------------------------------
# <above: section heading!>

a =  $(aaa)
#      ^^^     variable.other.makefile
b =  $(bbb)
#      ^^^     variable.other.makefile
c = _$(ccc)_
#      ^^^     variable.other.makefile

#              |<scopes veritcally-aligned with this column!>
#
#      xxx <syntax lines are padded so all three scope specs are for these three same column indicies - allows for three identical scope spec lines, and improves readability!>
```

[1]: since: that provides better anchoring of the text for diffs and merges with `git`


# about `vscode-tmgrammar-test`

* may hang indefinitely with malformed scope specs
  * -> run with a timeout
