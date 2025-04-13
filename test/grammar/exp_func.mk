# SYNTAX TEST "source.makefile"


# ------------- in assignment-RHSs, in rule heads ------------- #


varnme0 = $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.scope.function-call.makefile
#           ^^^^^^^    meta.scope.expansion.makefile
#         ^^       ^   punctuation.definition.variable.makefile

varnme1 = $(dir  str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.scope.function-call.makefile
#         ^^        ^  punctuation.definition.variable.makefile

varnme2 = $(dir str )
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.scope.function-call.makefile
#         ^^        ^  punctuation.definition.variable.makefile

target__: $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.scope.function-call.makefile
#         ^^       ^   punctuation.definition.variable.makefile

$(dir a)= $(dir asg)
# ^^^       ^^^        support.function.dir.makefile
# ^^^^^     ^^^^^^^    meta.scope.function-call.makefile
#^     ^  ^^       ^   punctuation.definition.variable.makefile

$(dir r): $(dir rle)
# ^^^       ^^^        support.function.dir.makefile
# ^^^^^     ^^^^^^^    meta.scope.function-call.makefile
#^     ^  ^^       ^   punctuation.definition.variable.makefile

# not recognized as a built-in -> scoped as a variable:
not-fnc = $(xyz arg)
#           ^^^      - support.function.dir.makefile
#           ^^^^^^^  - meta.scope.function-call.makefile
#         ^^       ^   punctuation.definition.variable.makefile
#           ^^^^^^^    variable.other.makefile
#           ^^^^^^^    meta.scope.expansion.makefile


# --------------------------- nested -------------------------- #

v_0= $(dir s$(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

tgt: $(dir s$(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

v_1= $(dir  $(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

vb1= $(dir  ${dir s})
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

v_3= $(dir  $(varbl))
#      ^^^             support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile


# ------------------------- in recipes ------------------------ #

rule:
	cmd $(dir r)
#^^^^^^^^^^^^          meta.scope.recipe.makefile
#      ^^^             support.function.dir.makefile
#      ^^^^^           meta.scope.function-call.makefile
#      ^^^^^           meta.scope.expansion.makefile
#    ^^     ^          punctuation.definition.variable.makefile

RULE:
	$(dir r)
#^^^^^^^^              meta.scope.recipe.makefile
#  ^^^                 support.function.dir.makefile
#  ^^^^^               meta.scope.function-call.makefile
#^^     ^              punctuation.definition.variable.makefile


# --------------------------- commas -------------------------- #

vA= $(if t,y,n)
#         ^ ^         punctuation.separator.delimeter.comma.makefile
vA= $(if t,y,)
#         ^ ^         punctuation.separator.delimeter.comma.makefile
vE= $(myVar a,b)
#            ^      - punctuation.separator.delimeter.comma.makefile


# ------------------------- line-cont. ------------------------ #

vC= $(if t\
          ,y,n)
#         ^ ^         punctuation.separator.delimeter.comma.makefile
#         ^^^^        meta.scope.expansion.makefile

vD= $(if \
         t,y,n)
#         ^ ^         punctuation.separator.delimeter.comma.makefile
#         ^^^^        meta.scope.expansion.makefile


vE= $(if t\
,y,n)
#<-                   punctuation.separator.delimeter.comma.makefile

# ---------------------------- misc --------------------------- #

# NOT in $(dir cmt)
#          ^^^^^^^   - meta.scope.expansion.makefile
#          ^^^       - support.function.dir.makefile
#          ^^^^^^^   - meta.scope.function-call.makefile
#        ^^       ^  - punctuation.definition.variable.makefile
