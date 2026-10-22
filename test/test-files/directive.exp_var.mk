# SYNTAX TEST "source.makefile"


vpath %  $(var)_
#              ^      string.unquoted.path.makefile
#          ^^^        variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

unexport $(var)_
#          ^^^ ^      variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

undefine $(var)_
#          ^^^ ^      variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

export   $(var)_
#          ^^^ ^      variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

export v=$(var)
#          ^^^        variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

export   $(var)=v
#          ^^^        variable.other.makefile
#        ^^           punctuation.definition.template-expression.begin.makefile
#             ^       punctuation.definition.template-expression.end.makefile

override undefine $(var)_
#                   ^^^ ^ variable.other.makefile
#                 ^^      punctuation.definition.template-expression.begin.makefile
#                      ^  punctuation.definition.template-expression.end.makefile


# ----------------------- with substref ----------------------- #

vpath $(v:%o=%c)
#       ^             variable.other.makefile
#     ^^              punctuation.definition.template-expression.begin.makefile
#              ^      punctuation.definition.template-expression.end.makefile


# ------------------------ conditional ------------------------ #

ifeq ($(VAR),b)
#       ^^^          variable.other.makefile
#     ^^             punctuation.definition.template-expression.begin.makefile
#          ^         punctuation.definition.template-expression.end.makefile
#           ^        punctuation.separator.delimiter.comma.condition.makefile
endif

ifdef $(VAR)
#       ^^^          variable.other.makefile
#     ^^             punctuation.definition.template-expression.begin.makefile
#          ^         punctuation.definition.template-expression.end.makefile
endif
