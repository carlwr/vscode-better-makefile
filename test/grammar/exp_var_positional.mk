# SYNTAX TEST "source.makefile"


# --------------------- in assignment-RHSs -------------------- #

aaaa = $1a
#       ^      variable.parameter.positional.makefile
#       ^      meta.scope.expansion.makefile
#      ^       punctuation.definition.variable.makefile

nme = $(2)a
#       ^      variable.parameter.positional.makefile
nme = ${3}a
#       ^      variable.parameter.positional.makefile



# ------------------------- negatives ------------------------- #

usr = $(1D)U
#       ^^   - variable.parameter.positional.makefile
#       ^^     meta.scope.expansion.makefile
usr = $(1x)
#       ^^   - variable.parameter.positional.makefile
#       ^^     meta.scope.expansion.makefile
usr = $(x1)
#       ^^   - variable.parameter.positional.makefile
#       ^^     meta.scope.expansion.makefile

# -------------------------- substref ------------------------- #

N = $(1:a%=%)
#     ^        variable.parameter.positional.makefile
#^^^^^ ^^^^^ - variable.parameter.positional.makefile
#   ^^      ^  punctuation.definition.variable.makefile
#        ^ ^   constant.other.placeholder.substref.percent.makefile
#       ^^^^   meta.substref.makefile


# --------------------------- nested -------------------------- #

h = $(h$1h)
#       ^      variable.parameter.positional.makefile
#   ^^ ^  ^    punctuation.definition.variable.makefile

i =  $($1)
#       ^      variable.parameter.positional.makefile
#    ^^^ ^     punctuation.definition.variable.makefile

j=$(if $1,j,)
#       ^      variable.parameter.positional.makefile
#      ^       punctuation.definition.variable.makefile

c= $(d$(1)e)
#       ^      variable.parameter.positional.makefile



# ------------------------- in recipes ------------------------ #

kkkk:
	doit _$1_
#^^^^^^^^^     meta.scope.recipe.makefile
#       ^      variable.parameter.positional.makefile
#      ^       punctuation.definition.variable.makefile
