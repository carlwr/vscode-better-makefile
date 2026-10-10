# SYNTAX TEST "source.makefile"

ifdef SHELL
#     ^^^^^       variable.language.readwrite.special.makefile
#     ^^^^^       variable.other.makefile
endif

ifndef CURDIR
#      ^^^^^^     variable.language.constant.special.makefile
endif

ifeq (a,b)
else ifdef SHELL
#          ^^^^^  variable.language.readwrite.special.makefile
endif


# ------------------------- negatives ------------------------- #

ifdef MYSHELL
#     ^^^^^^^   - variable.language.readwrite.special.makefile
endif

ifeq (SHELL,x)
#     ^^^^^     - variable.other.makefile
endif

ifeq (ifdef x,y)
#           ^   - variable.other.makefile
endif


# -------------------------- operand -------------------------- #

# make takes exactly one word; a second word is a syntax error

n := SHELL
ifdef $(n)
expandedOperand := ok
endif
## /^expandedOperand := ok/

ifdef SHELL#cmt
#     ^^^^^       variable.language.readwrite.special.makefile
commentStripped := ok
endif
## /^commentStripped := ok/
