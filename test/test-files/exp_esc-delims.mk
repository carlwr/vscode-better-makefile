# SYNTAX TEST "source.makefile"


# prepare
# -------

# helper vars:

bbB  := bb\\#       ## /^(?x)   \QbbB := bb\\E  $  /
bBB  := b\\\\#      ## /^(?x)   \QbBB := b\\\E  $  /


# create vars with names that include backslash:

$(bbB) := bbB#      ## /^(?x)   \Qbb\ := bbB\E  $  /
$(bBB) := bBB#      ## /^(?x)   \Qb\\ := bBB\E  $  /



# tests
# -----

# make behaviour: `$(..\)` -> the \ is not special; does not escape the `)`
#
# below:
# - the above is shown by the parseAssert tests
# - grammar adherence to the above is tested with the scope tests


v6 := a_$(bb\)_x)   ##  /^\Qv6 := a_bbB_x)  /
#         ^^^           variable.other.makefile
#       ^^              punctuation.definition.template-expression.begin.makefile
#            ^          punctuation.definition.template-expression.end.makefile
#               ^     - punctuation.definition.template-expression.end.makefile

v7 := a_$(b\\)_x)   ##  /^\Qv7 := a_bBB_x)  /
#         ^^^           variable.other.makefile
#       ^^              punctuation.definition.template-expression.begin.makefile
#            ^          punctuation.definition.template-expression.end.makefile
#               ^     - punctuation.definition.template-expression.end.makefile

t6__: a_$(bb\)_x)   ##  /^\Qt6__: a_bbB_x)/
#         ^^^           variable.other.makefile
#       ^^              punctuation.definition.template-expression.begin.makefile
#            ^          punctuation.definition.template-expression.end.makefile
#               ^     - punctuation.definition.template-expression.end.makefile

t7__: a_$(b\\)_x)   ##  /^\Qt7__: a_bBB_x)/
#         ^^^           variable.other.makefile
#       ^^              punctuation.definition.template-expression.begin.makefile
#            ^          punctuation.definition.template-expression.end.makefile
#               ^     - punctuation.definition.template-expression.end.makefile
