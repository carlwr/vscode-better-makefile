# SYNTAX TEST "source.makefile"


# ------------------------ smoke tests ------------------------ #

$(info message)
# ^^^^               support.function.info.makefile

$(info 1,2,3,4)
# ^^^^               support.function.info.makefile

$(info     msg)
# ^^^^               support.function.info.makefile

v00 = $(dir /path/f)
#       ^^^          support.function.dir.makefile


# -------------- typ. use - all args string-scoped ------------ #

$(info [DEBUG] q = 100%)
# ^^^^                             support.function.info.makefile

# TODO


# ------------- in assignment-RHSs, in rule heads ------------- #


varnme0 = $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.scope.expansion.makefile
#           ^^^^^^^    meta.scope.function-call.makefile

varnme1 = $(dir  str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.scope.function-call.makefile

varnme2 = $(dir str )
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.scope.function-call.makefile

target__: $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.scope.function-call.makefile

$(dir a)= $(dir asg)
# ^^^       ^^^        support.function.dir.makefile
# ^^^^^     ^^^^^^^    meta.scope.function-call.makefile

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


# --------------------- expansions in args -------------------- #

earg0:=$(dir _$(vv)_)
#        ^^^           support.function.dir.makefile
#               ^^     variable.other.makefile
#      ^^^^^^^^^  ^^ - variable.other.makefile

earg1:=$(if  _$(vv),)
#        ^^            support.function.if.makefile
#               ^^     variable.other.makefile
#     ^^^^^^^^^^  ^^ - variable.other.makefile


# --------------------------- nested -------------------------- #

v_0= $(dir s$(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

tgt: $(dir s$(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile

vb1= $(dir  ${dir s})
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile
#    ^^     ^^     ^^  punctuation.definition.variable.makefile

v_3= $(dir  $(varbl))
#      ^^^             support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.scope.function-call.makefile


# ------------------------- in recipes ------------------------ #

rule:
	cmd $(dir r)
#^^^^^^^^^^^^          meta.scope.recipe.makefile
#      ^^^             support.function.dir.makefile
#      ^^^^^           meta.scope.function-call.makefile
#      ^^^^^           meta.scope.expansion.makefile


RULE:
	$(dir r)
#^^^^^^^^              meta.scope.recipe.makefile
#  ^^^                 support.function.dir.makefile
#  ^^^^^               meta.scope.function-call.makefile


# --------------------------- commas -------------------------- #

vA= $(if t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.makefile
#   ^^^^^           - meta.function-call.arguments.makefile

vA= $(if t,y,)
#         ^ ^         punctuation.separator.delimiter.comma.makefile

vE= $(myVar a,b)
#            ^      - punctuation.separator.delimiter.comma.makefile
#   ^^^^^^^^^^^^    - meta.function-call.arguments.makefile

# commas cannot be escaped:
com0V := $(if 1,T\,f)   ## /^\Qcom0V := T\/
com1V := $(if  ,T\,f)   ## /^\Qcom1V := f/

# ...test it:
com0T := $(if 1,T\,f)
# TODO "...test it:"


# space after a comma is part of the argument:
V_comSp := $(if t, y,n)
ifeq '$(V_comSp)' ' y'
  comSp_isSignificant := true
else
  comSp_isSignificant := false
endif
## /^comSp_isSignificant := true/

# ...test:
V_comSp := $(if t, y,n)
# TODO "...test:"


# ------------------------- line-cont. ------------------------ #

vC= $(if t\
          ,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.makefile
#         ^^^^        meta.scope.expansion.makefile

vD= $(if \
         t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.makefile
#         ^^^^        meta.scope.expansion.makefile

vE= $(if t\
,y,n)
#<-                   punctuation.separator.delimiter.comma.makefile

vF= $(if \\\
         t,y,n)
#         ^^^^        meta.scope.expansion.makefile

vG= $(if \\ \
         t,y,n)
#         ^^^^        meta.scope.expansion.makefile


# --------------------------- hashes -------------------------- #

func0 := $(if ,,a #b  )     ## /^\Qfunc0 := a #b  /
#                 ^       - comment.line.number-sign.makefile
#        ^^           ^     punctuation.definition.variable.makefile
#          ^^^^^^^^^^^      meta.scope.function-call.makefile
#          ^^^^^^^^^^^      meta.scope.expansion.makefile

func1 := $(if ,,a\#b  )     ## /^\Qfunc1 := a\#b  /
#                ^        - constant.character.escape.backslash.makefile
#                 ^       - meta.escaped-char.makefile
#                 ^       - comment.line.number-sign.makefile
#        ^^           ^     punctuation.definition.variable.makefile
#          ^^^^^^^^^^^      meta.scope.function-call.makefile
#          ^^^^^^^^^^^      meta.scope.expansion.makefile

func2 := $(dir  a\#b  )
#                 ^       - comment.line.number-sign.makefile


# ---------------------------- misc --------------------------- #

# space must follow after the function name for a built-in function to be recognized:
_tst0V := x$(if,T,f)y  ## /^\Q_tst0V := xy/

# test it:
_tst0T := x$(if,T,f)y
# TODO _tst0T


# ----------------- not recognized in comment ----------------- #

# NOT in $(dir cmt)
#          ^^^^^^^   - meta.scope.expansion.makefile
#          ^^^       - support.function.dir.makefile
#          ^^^^^^^   - meta.scope.function-call.makefile
#        ^^       ^  - punctuation.definition.variable.makefile
