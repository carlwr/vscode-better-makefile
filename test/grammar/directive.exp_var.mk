# SYNTAX TEST "source.makefile"


# --------------------------- vpath --------------------------- #

vpath % $(VAR)
#         ^^^               variable.other.makefile
#       ^^   ^              punctuation.definition.variable.makefile


# ------------------------ conditional ------------------------ #

ifeq ($(VAR),b)
#       ^^^                variable.other.makefile
#     ^^   ^               punctuation.definition.variable.makefile
#           ^              punctuation.separator.delimiter.comma.makefile
endif

ifdef $(VAR)
#       ^^^                variable.other.makefile
#     ^^   ^               punctuation.definition.variable.makefile
endif
