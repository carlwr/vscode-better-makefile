# SYNTAX TEST "source.makefile"

export SHELL
#      ^^^^^          variable.language.readwrite.special.makefile
#      ^^^^^          variable.other.makefile

undefine CURDIR
#        ^^^^^^       variable.language.constant.special.makefile

unexport A SHELL B
#          ^^^^^      variable.language.readwrite.special.makefile


# ------------------------- negatives ------------------------- #

export MYSHELL
#      ^^^^^^^      - variable.language.readwrite.special.makefile

export.RECIPEPREFIX = x
#     ^^^^^^^^^^^^^ - variable.language.readwrite.special.makefile
