# SYNTAX TEST "source.makefile"

export SHELL
#      ^^^^^          variable.language.readwrite.makefile
#      ^^^^^          variable.other.makefile

undefine CURDIR
#        ^^^^^^       variable.language.constant.makefile

unexport A SHELL B
#          ^^^^^      variable.language.readwrite.makefile


# ------------------------- negatives ------------------------- #

export MYSHELL
#      ^^^^^^^      - variable.language.readwrite.makefile

export.RECIPEPREFIX = x
#     ^^^^^^^^^^^^^ - variable.language.readwrite.makefile
