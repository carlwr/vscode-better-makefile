# SYNTAX TEST "source.makefile"


# --------------------------- vpath --------------------------- #

vpath % $(VAR)
#         ^^^         variable.other.makefile
#       ^^   ^        punctuation.definition.variable.makefile

vpath $(v:%o=%c)
#       ^             variable.other.makefile
#     ^^              punctuation.definition.template-expression.begin.makefile
#              ^      punctuation.definition.template-expression.end.makefile


# ------------------------ conditional ------------------------ #

ifeq ($(VAR),b)
#       ^^^          variable.other.makefile
#     ^^   ^         punctuation.definition.variable.makefile
#           ^        punctuation.separator.delimiter.comma.condition.makefile
endif

ifdef $(VAR)
#       ^^^          variable.other.makefile
#     ^^   ^         punctuation.definition.variable.makefile
endif
