# SYNTAX TEST "source.makefile"


# --------------------- scoping principle --------------------- #

# in single-char expansion, the $ is scoped as belonging to the variable:

scoping0 = $c
#          ^^       variable.other.makefile
#           ^       meta.scope.expansion.makefile
#          ^        punctuation.definition.variable.makefile

# but in $(..) expansions, the $( and ) are not:

scoping1 = $(var)
#            ^^^    variable.other.makefile
#            ^^^    meta.scope.expansion.makefile
#          ^^   ^   punctuation.definition.variable.makefile


# ------------- in assignment-RHSs, in rule heads ------------- #


name = $(NME)
#        ^^^        meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#           ^       punctuation.definition.template-expression.end.makefile
#^^^^^^^^   ^     - meta.scope.expansion.makefile

nme0 = $(dir str)
#        ^^^^^^^    meta.scope.function-call.makefile
#        ^^^^^^^    meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#               ^   punctuation.definition.template-expression.end.makefile

aaaa = $@a
#       ^           meta.scope.expansion.makefile
#^^^^^^^ ^        - meta.scope.expansion.makefile
#      ^            punctuation.definition.variable.makefile

aaab = $c
#       ^           meta.scope.expansion.makefile
#^^^^^^^ ^        - meta.scope.expansion.makefile
#      ^            punctuation.definition.variable.makefile

aaac = $(c)a
#      ^^ ^         punctuation.definition.variable.makefile
#        ^          meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#         ^         punctuation.definition.template-expression.end.makefile

aaad = ${c}a
#        ^          meta.scope.expansion.makefile
#      ^^           punctuation.definition.template-expression.begin.makefile
#         ^         punctuation.definition.template-expression.end.makefile

aaad = $cX
#      ^            punctuation.definition.variable.makefile
#       ^           meta.scope.expansion.makefile
#        ^        - meta.scope.expansion.makefile

targt: $(TGT)
#      ^^   ^       punctuation.definition.variable.makefile
#        ^^^        meta.scope.expansion.makefile

$(e) = $(EXP)
# ^      ^^^        meta.scope.expansion.makefile

ddd = $(x$$y)
#        ^^         constant.character.escape.dollar.makefile
#        ^^       - punctuation.definition.variable.makefile
#       ^^^^        meta.scope.expansion.makefile

$(V) : $(exp)
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
