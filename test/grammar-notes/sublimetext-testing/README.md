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


## Provenance of the `_ref_` files

Both are third-party material, kept for reference. They are not part of the extension and not covered by this repository's MIT license. Copyright Sublime HQ Pty Ltd (and contributors).

`_ref_sublime-testing-Makefile-testfile.mk`
- https://github.com/sublimehq/Packages/blob/master/Makefile/syntax_test_makefile.mak
- commit: https://github.com/sublimehq/Packages/commit/3b2e548ca24d0a2057819b5832bc515fe97992df
- only change vs. upstream: "Merge Conflict Markers" section dropped (its raw markers make git and editors treat the file as conflicted)

`_ref_sublime-testing_doc.md`
- the "Testing" section of https://www.sublimetext.com/docs/syntax.html, as markdown
