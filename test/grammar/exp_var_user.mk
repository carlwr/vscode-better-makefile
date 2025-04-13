# SYNTAX TEST "source.makefile"


# ------------- in assignment-RHSs, in rule heads ------------- #


name = $(nme)
#        ^^^        variable.other.makefile
#        ^^^        meta.scope.expansion.makefile
#      ^^   ^       punctuation.definition.variable.makefile
#^^^^^^^^   ^     - variable.other.makefile
#^^^^^^^^   ^     - meta.scope.expansion.makefile
#<-               - variable.other.makefile

targt: $(tgt)
#        ^^^        variable.other.makefile
#      ^^   ^       punctuation.definition.variable.makefile
#^^^^^^^^   ^     - variable.other.makefile
#<-               - variable.other.makefile


tight_=$(tig)
#        ^^^        variable.other.makefile
#      ^^   ^       punctuation.definition.variable.makefile
#^^^^^^^^   ^     - variable.other.makefile
#<-               - variable.other.makefile

TIGHT_:$(TIG)
#        ^^^        variable.other.makefile
#      ^^   ^       punctuation.definition.variable.makefile
#^^^^^^^^   ^     - variable.other.makefile
#<-               - variable.other.makefile

spc = $(sp ace)     ## /\Qspc = $(sp ace)/
#       ^^^^^^      variable.other.makefile
#^^                 variable.other.assignment.makefile

$(e) = $(exp)
# ^      ^^^        variable.other.makefile
#^ ^   ^^   ^       punctuation.definition.variable.makefile
#<-                 punctuation.definition.variable.makefile

ddd = $(v$$r)
#       ^  ^        variable.other.makefile
#        ^^         constant.character.escape.dollar.makefile


$(E) : $(EXP)
# ^      ^^^        variable.other.makefile
#^ ^   ^^   ^       punctuation.definition.variable.makefile
#<-                 punctuation.definition.variable.makefile



# --------------------------- nested -------------------------- #


nest = $(nst$(inr))s
#        ^^^  ^^^        variable.other.makefile
#      ^^   ^^   ^^      punctuation.definition.variable.makefile
#                  ^   - variable.other.makefile

nest = ___$($(inr))s
#             ^^^        variable.other.makefile
#         ^^^^   ^^      punctuation.definition.variable.makefile
#      ^^^^^^^   ^^^   - variable.other.makefile


nest = $(nst${inr})s
#        ^^^  ^^^        variable.other.makefile
#      ^^   ^^   ^^      punctuation.definition.variable.makefile
#                  ^   - variable.other.makefile

nest = $(nst${i r})s
#        ^^^  ^^^        variable.other.makefile
#      ^^   ^^   ^^      punctuation.definition.variable.makefile
#                  ^   - variable.other.makefile

NEST_: $(NST${INR})
#        ^^^  ^^^        variable.other.makefile
#      ^^   ^^   ^^      punctuation.definition.variable.makefile


# we prefer that nested punctuation does not inherit the outer `variable.other` scope [1]; this test has some chance of failing if that is not the case:
nest = $(nst$(inr))s
#           ^^   ^     - variable.other.makefile 
#             """
#               \_______|here, we want one variable.other scope, not
#                       |two nested within each other 

# [1] since:
#
# - with nested expansions, we don't want to scope with variable.other for all inner scopes, just because the expansion is part of the name of a variable
#
# - what we scope with variable.other, we also want to scope with some .string. scope - that makes VS Code not recognize bracket pairs for that text, i.e. e.g. } in $} (which refers to the char named `}`) is then not marked as an actual bracket by VS Code, which is helpful
#   i.e. single-char expansions like these:
v_01 = $}
#       ^               variable.other.makefile
v_02 = $)
#       ^               variable.other.makefile


# ------------------------- in recipes ------------------------ #

rule:
	cmd $(aaa)
#^^^^^^^^^^             meta.scope.recipe.makefile
#      ^^^              variable.other.makefile
#    ^^   ^             punctuation.definition.variable.makefile

RULE:
	$(bbb)
#^^^^^^                 meta.scope.recipe.makefile
#  ^^^                  variable.other.makefile
#^^   ^                 punctuation.definition.variable.makefile


# ---------------------------- misc --------------------------- #


x= _$(ab)c $(de$(fg)) $(words $(hi))
#     ^^     ^^  ^^             ^^    variable.other.makefile
#   ^^  ^  ^^  ^^  ^^ ^^      ^^  ^^  punctuation.definition.variable.makefile

X: _$(AB)C $(DE$(FG)) $(words $(HI))
#     ^^     ^^  ^^             ^^    variable.other.makefile
#   ^^  ^  ^^  ^^  ^^ ^^      ^^  ^^  punctuation.definition.variable.makefile


# NOT in $(comment)
#          ^^^^^^^                  - variable.other.makefile
#        ^^       ^                 - punctuation.definition.variable.makefile
