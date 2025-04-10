# invalid makefiles

TODO consider adding .mk files in a dir
    should-not-parse/
with automatic testing asserting that for each file, both of the following hold:
* `make -n <file>` fails and reports an error
* the grammar specifies some scope meta.invalid etc. for some part of the file


# filenames

preliminary filename prefix conventions:
```
assign

define

exp_var_user
exp_var_auto
exp_var_positional
exp_var_builtin
exp_var_substref

exp_fun_builtin

rule_explicit
rule_pattern
rule_staticPattern
rule_builtinTarget
rule_targetSpecificVar
rule_recipe

conditional

comment

directive

other
```

# refs

Useful GNU make ref:
```bash
info --node 'quick' make | grep -Po "(?x) (?<=^') .* (?='$)" | less
```


# SublimeText grammar tests refs

The grammar tests use the npm package `vscode-tmgrammar-test`. It is a port of / inspired by SublimeText's grammar testing tool.

`vscode-tmgrammar-test` lacks documentation, but SublimeText's grammar test documentation is mostly valid also for `vscode-tmgrammar-test`.

In the directory of this files, the following files, with filename prefix `_ref_`, can be found:

1. SublimeText's grammar test documentation webpage in markdown format

2. SublimeText's _test file_ for testing the _SublimeText_ Makefile grammar
    - this file can be useful in two ways:
      - as a rich set of examples for the test file syntax that both SublimeText grammar tests and `vscode-tmgrammar-test` use
      - as an inspiration for Makefile syntax situations that can be valuable to test
    - note that:
      - SublimeText grammars do not use the textMate grammar format
      - SublimeText grammars are more expressive than textMate grammars, and hence the SublimeText grammar will be able to identify some Makefile syntax elements that a textMate grammar _cannot_ identify
      - the SublimeText Makefile grammar makes different scope name choices than the textMate grammar of this extension
