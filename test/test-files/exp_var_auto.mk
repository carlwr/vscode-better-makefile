# SYNTAX TEST "source.makefile"


# --------------------- in assignment-RHSs -------------------- #

aaaa = $@a
#      ^^      variable.parameter.automatic.makefile
#      ^       punctuation.definition.variable.makefile
#       ^      meta.scope.expansion.makefile
#       ^    - punctuation.definition.variable.makefile
#^^^^^^  ^   - variable.parameter.automatic.makefile
#^^^^^^^ ^   - meta.scope.expansion.makefile


tight_=$@t
#      ^^      variable.parameter.automatic.makefile
#^^^^^^  ^   - variable.parameter.automatic.makefile

nme = $(@)a
#       ^      variable.parameter.automatic.makefile
#       ^      meta.scope.expansion.makefile
#^^^^^^^ ^   - variable.parameter.automatic.makefile
#^^^^^^^ ^^  - meta.scope.expansion.makefile

nme = ${@}a
#       ^      variable.parameter.automatic.makefile
#^^^^^^^ ^   - variable.parameter.automatic.makefile

usr = $(u)A
#       ^    - variable.parameter.automatic.makefile

nme = $(@D)n
#       ^^     variable.parameter.automatic.makefile
#^^^^^^^  ^  - variable.parameter.automatic.makefile
#     ^^       punctuation.definition.template-expression.begin.makefile
#         ^    punctuation.definition.template-expression.end.makefile
#     ^^  ^  - punctuation.definition.variable.makefile

NME = ${@D}N
#       ^^     variable.parameter.automatic.makefile
#^^^^^^^  ^  - variable.parameter.automatic.makefile
#     ^^       punctuation.definition.template-expression.begin.makefile
#         ^    punctuation.definition.template-expression.end.makefile
#     ^^  ^  - punctuation.definition.variable.makefile


# ------------------------- negatives ------------------------- #

user = $uU
#       ^    - variable.parameter.automatic.makefile

usr = $(uD)U
#       ^^   - variable.parameter.automatic.makefile

usr = $(@x)
#       ^^   - variable.parameter.automatic.makefile
#       ^^     meta.scope.expansion.makefile

usr = $(@@)
#       ^^   - variable.parameter.automatic.makefile
#       ^^     meta.scope.expansion.makefile

usr = $(x@)
#       ^^   - variable.parameter.automatic.makefile
#       ^^     meta.scope.expansion.makefile

usr =  $@@
#      ^       punctuation.definition.variable.makefile
#      ^^      variable.parameter.automatic.makefile
#       ^      meta.scope.expansion.makefile
#        ^   - variable.parameter.automatic.makefile
#        ^   - meta.scope.expansion.makefile

usr = $$@
#       ^    - variable.parameter.automatic.makefile
#     ^^^    - meta.scope.expansion.makefile


# -------------------------- substref ------------------------- #

N =$(%:a%=%)
#    ^         variable.parameter.automatic.makefile
#  ^^          punctuation.definition.template-expression.begin.makefile
#          ^   punctuation.definition.template-expression.end.makefile
#  ^^      ^ - punctuation.definition.variable.makefile
#       ^ ^    constant.other.placeholder.substref.percent.makefile
#     ^^^^^    meta.substref.makefile
#    ^^^^^^    meta.scope.expansion.makefile
#^^^^ ^^^^^  - variable.parameter.automatic.makefile


# -------------------------- variants ------------------------- #

bbbb = $%
#      ^^      variable.parameter.automatic.makefile
cccc = $<
#      ^^      variable.parameter.automatic.makefile
dddd = $?
#      ^^      variable.parameter.automatic.makefile
eeee = $^
#      ^^      variable.parameter.automatic.makefile
ffff = $+
#      ^^      variable.parameter.automatic.makefile
gggg = $*
#      ^^      variable.parameter.automatic.makefile
#       ^    - variable.language.special.wildcard.makefile

xxx = $(@F)
#       ^^     variable.parameter.automatic.makefile
yyy = $(%F)
#       ^^     variable.parameter.automatic.makefile
zzz = $(*F)
#       ^^     variable.parameter.automatic.makefile


# --------------------------- nested -------------------------- #

h = $(h$@h)
#      ^^      variable.parameter.automatic.makefile
#^^^^^^  ^^  - variable.parameter.automatic.makefile
#      ^       punctuation.definition.variable.makefile
#   ^^         punctuation.definition.template-expression.begin.makefile
#         ^    punctuation.definition.template-expression.end.makefile

i =  $($@)
#      ^^      variable.parameter.automatic.makefile
#      ^       punctuation.definition.variable.makefile

j=$(if $@,j,)
#      ^^      variable.parameter.automatic.makefile
#      ^       punctuation.definition.variable.makefile

c= $(d$(@)e)
#       ^      variable.parameter.automatic.makefile
#^^^^^^^ ^^  - variable.parameter.automatic.makefile



# ------------------------- in recipes ------------------------ #

kkkk:
	doit _$@_
#^^^^^^^^^     meta.scope.recipe.makefile
#      ^^      variable.parameter.automatic.makefile
#      ^       punctuation.definition.variable.makefile


# ---------------------------- misc --------------------------- #

# don't require the grammar to describe this GNU make behaviour, therefore, only parse tests on these:
l0 = $}        ## /^\Ql0 = $} \E/
l1 = $)        ## /^\Ql1 = $) \E/


# cmt: $@
#      ^^    - variable.parameter.automatic.makefile

# cmt:$(@)
#       ^    - variable.parameter.automatic.makefile
