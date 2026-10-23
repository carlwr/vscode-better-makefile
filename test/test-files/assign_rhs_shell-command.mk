# SYNTAX TEST "source.makefile"


SHELL := true
  # so that nothing meaningful can be executed as a shell command
  # (`true` takes any args, prints nothing to stdout)
  #
  # the parse assertion-like `# /../` is sometimes given
  # (shows what the make db _would_ have contained; not actively tested)


# basic
# -----

v1 != echo a b          # /^v1 = a b$/
#     ^^^^^^^^^           meta.shell-command.assignment.makefile
#  ^^^                  - meta.shell-command.assignment.makefile
#     ^^^^^^^^^         - string.unquoted.makefile
#     ^^^^^^^^^         - meta.string.makefile

v2!=echo a              # /^v2 = a$/
#   ^^^^^^                meta.shell-command.assignment.makefile
#  ^                    - meta.shell-command.assignment.makefile

v3 !=   echo a
#       ^^^^^^            meta.shell-command.assignment.makefile
#  ^^^^^                - meta.shell-command.assignment.makefile


# expansions, escapes, comments
# -----------------------------

v4 != echo $(X) $$y # c
#     ^^^^^^^^^^^^^^^^^   meta.shell-command.assignment.makefile
#          ^^             punctuation.definition.template-expression.begin.makefile
#               ^^        constant.character.escape.dollar.makefile
#                   ^^^   comment.line.number-sign.makefile
#     ^^^^^^^^^^^^^^^^^ - string.unquoted.makefile

v5 != echo '$$x'        # /^v5 = \$x$/
v6 != echo a # b        # /^v6 = a$/
v6b != echo a\#b        # /^v6b = a#b$/
#            ^^           constant.character.escape.hash.makefile


# empty RHS; following lines unaffected
# -------------------------------------

v7 !=
#  ^^                     keyword.operator.assignment.makefile
v8 := s
#     ^                   string.unquoted.makefile
#     ^                 - meta.shell-command.assignment.makefile


# line continuation
# -----------------

v9 != echo a \
  b
# ^                       meta.shell-command.assignment.makefile
w1 := s
#     ^                   string.unquoted.makefile
#     ^                 - meta.shell-command.assignment.makefile

# odd no. of \-s: line cont.; make halves the preceding \-s
v10 != echo a\\\
  b                     # /^v10 = a b$/

v10_ != echo a\\\
#             ^^          constant.character.escape.backslash.makefile
#               ^         punctuation.separator.continuation.makefile


# other assignment contexts
# -------------------------

w2 = a != b             ## /^w2 = a != b +$/
#    ^^^^^^               string.unquoted.makefile
#    ^^^^^^             - meta.shell-command.assignment.makefile

override w3 != echo a
#              ^^^^^^     meta.shell-command.assignment.makefile

export w4 != echo a
#            ^^^^^^       meta.shell-command.assignment.makefile

tgt: w5 != echo a
#          ^^^^^^         meta.shell-command.assignment.makefile
