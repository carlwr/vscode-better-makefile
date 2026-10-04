# SYNTAX TEST "source.makefile"


# ------------- in assignment-RHSs, in rule heads ------------- #


name = $(NME)
#        ^^^        meta.scope.expansion.makefile
#      ^^   ^       punctuation.definition.variable.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#           ^       punctuation.definition.template-expression.end.makefile
#^^^^^^^^   ^     - meta.scope.expansion.makefile

nme0 = $(dir str)
#        ^^^^^^^    meta.scope.function-call.makefile
#        ^^^^^^^    meta.scope.expansion.makefile
#      ^^       ^   punctuation.definition.variable.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#               ^   punctuation.definition.template-expression.end.makefile

aaaa = $@a
#       ^           meta.scope.expansion.makefile
#^^^^^^^ ^        - meta.scope.expansion.makefile
#      ^            punctuation.definition.variable.makefile
#      ^            punctuation.section.embedded.makefile

aaab = $c
#       ^           meta.scope.expansion.makefile
#^^^^^^^ ^        - meta.scope.expansion.makefile
#      ^            punctuation.definition.variable.makefile
#      ^            punctuation.section.embedded.makefile

aaac = $(c)a
#      ^^ ^         punctuation.definition.variable.makefile
#        ^          meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#         ^         punctuation.definition.template-expression.end.makefile

aaad = ${c}a
#      ^^ ^         punctuation.definition.variable.makefile
#        ^          meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#         ^         punctuation.definition.template-expression.end.makefile

aaad = $cX
#      ^            punctuation.definition.variable.makefile
#      ^            punctuation.section.embedded.makefile
#       ^           meta.scope.expansion.makefile
#        ^        - meta.scope.expansion.makefile

targt: $(TGT)
#      ^^   ^       punctuation.definition.variable.makefile
#        ^^^        meta.scope.expansion.makefile

$(e) = $(EXP)
#^ ^   ^^   ^       punctuation.definition.variable.makefile
#<-                 punctuation.definition.variable.makefile
# ^      ^^^        meta.scope.expansion.makefile

ddd = $(x$$y)
#        ^^         constant.character.escape.dollar.makefile
#        ^^       - punctuation.definition.variable.makefile
#        ^^       - punctuation.section.embedded.makefile
#       ^^^^        meta.scope.expansion.makefile

$(V) : $(exp)
#^ ^   ^^   ^       punctuation.definition.variable.makefile
#<-                 punctuation.definition.variable.makefile
#<-                 punctuation.definition.template-expression.begin.makefile
#^                  punctuation.definition.template-expression.begin.makefile
#  ^                punctuation.definition.template-expression.end.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#           ^       punctuation.definition.template-expression.end.makefile
# ^      ^^^        meta.scope.expansion.makefile


# --------------------------- nested -------------------------- #


nest = $(nst$(INR))s
#      ^^   ^^   ^^      punctuation.definition.variable.makefile



# ------------------------- in recipes ------------------------ #

targ:
	cmd $(AAA)
#    ^^   ^             punctuation.definition.variable.makefile
