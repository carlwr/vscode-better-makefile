# SYNTAX TEST "source.makefile"


# ------------------------ smoke tests ------------------------ #

$(info message)
# ^^^^               support.function.info.makefile
#      ^^^^^^^       string.unquoted.makefile

$(info 1,2,3,4)
# ^^^^               support.function.info.makefile

$(info     msg)
# ^^^^               support.function.info.makefile
#          ^^^       string.unquoted.makefile
#      ^^^^        - string.unquoted.makefile

v00 = $(dir /path/f)
#       ^^^          support.function.dir.makefile
#           ^^^^^^^  string.unquoted.makefile


# -------------- typ. use - all args string-scoped ------------ #

$(info [DEBUG] q = 100%)
# ^^^^                             support.function.info.makefile
#      ^^^^^^^^^^^^^^^^            string.unquoted.makefile

v20 = $(dir (=?[]*:\ ,\\ (_)(){}))
#       ^^^                        support.function.dir.makefile
#           ^^^^^^^^^^^^^^^^^^^^^  string.unquoted.makefile

v30 = $(let p x,$(PATH):/d/,ok?,_)
#       ^^^                        support.function.let.makefile
#           ^ ^        ^^^^ ^^^ ^  string.unquoted.makefile


# ------------- in assignment-RHSs, in rule heads ------------- #

varnme0 = $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.scope.expansion.makefile
#           ^^^^^^^    meta.function-call.makefile
#               ^^^    meta.function-call.arguments.makefile
#               ^^^    string.unquoted.makefile
#           ^^^^     - string.unquoted.makefile
#         ^^^^^^   ^ - meta.function-call.arguments.makefile

varnme1 = $(dir  str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.function-call.makefile
#                ^^^   meta.function-call.arguments.makefile
#                ^^^   string.unquoted.makefile
#           ^^^^^    - string.unquoted.makefile

varnme2 = $(dir _$$_)
#           ^^^        support.function.dir.makefile
#                ^^    constant.character.escape.dollar.makefile
#               ^  ^   string.unquoted.makefile
#           ^^^^^^^^   meta.function-call.makefile

varnmeA = $(dir  s r)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.function-call.makefile
#                ^^^   meta.function-call.arguments.makefile
#                ^ ^   string.unquoted.makefile

varnmeAv= $(value  s r)
#           ^^^^^      support.function.value.makefile
#           ^^^^^^^^^^ meta.function-call.makefile
#                  ^^^ meta.function-call.arguments.makefile
#                  ^ ^ variable.other.makefile

varnmeB = $(dir )
#           ^^^        support.function.dir.makefile
#           ^^^^       meta.function-call.makefile
#         ^^^^^^^    - meta.function-call.arguments.makefile
#         ^^^^^^^    - string.unquoted.makefile

c0 = $(dir .-&"'^;)
#      ^^^             support.function.dir.makefile
#      ^^^^^^^^^^^     meta.function-call.makefile
#          ^^^^^^^     meta.function-call.arguments.makefile
#          ^^^^^^^     string.unquoted.makefile
#                 ^  - meta.function-call.makefile
#                 ^  - meta.function-call.arguments.makefile
#                 ^  - string.unquoted.makefile

varnme2 = $(dir str )
#           ^^^        support.function.dir.makefile
#           ^^^^^^^^   meta.function-call.makefile

target__: $(dir str)
#           ^^^        support.function.dir.makefile
#           ^^^^^^^    meta.function-call.makefile
#               ^^^    meta.function-call.arguments.makefile
#               ^^^    string.unquoted.makefile

$(dir a)= $(dir asg)
# ^^^       ^^^        support.function.dir.makefile
# ^^^^^     ^^^^^^^    meta.function-call.makefile
#     ^         ^^^    meta.function-call.arguments.makefile
#     ^         ^^^    string.unquoted.makefile

$(dir r): $(dir rle)
# ^^^       ^^^        support.function.dir.makefile
# ^^^^^     ^^^^^^^    meta.function-call.makefile
#<-                    punctuation.definition.template-expression.begin.makefile
#^        ^^           punctuation.definition.template-expression.begin.makefile
#      ^           ^   punctuation.definition.template-expression.end.makefile
#     ^         ^^^    meta.function-call.arguments.makefile
#     ^         ^^^    string.unquoted.makefile


# not recognized as a built-in -> scoped as a variable:
not-fnc = $(xyz arg)
#           ^^^      - support.function.dir.makefile
#           ^^^^^^^  - meta.function-call.makefile
#         ^^           punctuation.definition.template-expression.begin.makefile
#                  ^   punctuation.definition.template-expression.end.makefile
#           ^^^^^^^    variable.other.makefile
#           ^^^^^^^    meta.scope.expansion.makefile
#         ^^^^^^^^^^ - meta.function-call.arguments.makefile
#         ^^^^^^^^^^ - string.unquoted.makefile

not-fn2 = $(dirName)
#           ^^^      - support.function.dir.makefile
#           ^^^^^^^  - meta.function-call.makefile


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
#      ^^^^^^^^^^^^^   meta.function-call.makefile
#    ^^     ^^         punctuation.definition.template-expression.begin.makefile
#                  ^^  punctuation.definition.template-expression.end.makefile
#          ^^^^^^^^^   meta.function-call.arguments.makefile
#          ^      ^    string.unquoted.makefile
#^^^^^^^^^^ ^^^^^^ ^ - string.unquoted.makefile

tgt: $(dir s$(dir s))
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.function-call.makefile

vb1= $(dir  ${dir s})
#      ^^^    ^^^      support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.function-call.makefile
#    ^^     ^^         punctuation.definition.template-expression.begin.makefile
#                  ^^  punctuation.definition.template-expression.end.makefile
#           ^^^^^^^^   meta.function-call.arguments.makefile
#                 ^    string.unquoted.makefile

v_3= $(dir  $(varbl))
#      ^^^             support.function.dir.makefile
#      ^^^^^^^^^^^^^   meta.function-call.makefile


# ------------------------- in recipes ------------------------ #

rule:
	cmd $(dir r)
#^^^^^^^^^^^^          meta.scope.recipe.makefile
#      ^^^             support.function.dir.makefile
#      ^^^^^           meta.function-call.makefile
#      ^^^^^           meta.scope.expansion.makefile

RULE:
	$(dir r)
#^^^^^^^^              meta.scope.recipe.makefile
#  ^^^                 support.function.dir.makefile
#  ^^^^^               meta.function-call.makefile

RULE-if:
	$(if ,)
#^^^^^^^               meta.scope.recipe.makefile
#  ^^                  support.function.if.makefile


# --------------------------- commas -------------------------- #

vA= $(if t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#     ^^              support.function.if.makefile
#        ^ ^ ^        string.unquoted.makefile
#        ^^^^^        meta.function-call.arguments.makefile
#   ^^^^^           - string.unquoted.makefile
#   ^^^^^           - meta.function-call.arguments.makefile

vA= $(if t,y,)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile

vB=  $(if ,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#          ^ ^        string.unquoted.makefile
#         ^^^^        meta.function-call.arguments.makefile
#    ^^^^^          - string.unquoted.makefile
#    ^^^^^          - meta.function-call.arguments.makefile

vC0= $(if  ,,y)
#          ^^         punctuation.separator.delimiter.comma.function.makefile
#            ^        string.unquoted.makefile
#          ^^^        meta.function-call.arguments.makefile

vC1= $(if 1,,)
#          ^^         punctuation.separator.delimiter.comma.function.makefile
#         ^           string.unquoted.makefile

vE= $(myVar a,b)
#            ^      - punctuation.separator.delimiter.comma.function.makefile
#   ^^^^^^^^^^^^    - string.unquoted.makefile
#   ^^^^^^^^^^^^    - meta.function-call.arguments.makefile


# commas cannot be escaped:
com0V := $(if 1,T\,f)   ## /^\Qcom0V := T\/
com1V := $(if  ,T\,f)   ## /^\Qcom1V := f/

# ...test it:
com0T := $(if 1,T\,f)
#              ^  ^   punctuation.separator.delimiter.comma.function.makefile
#                 ^ - string.unquoted.makefile
#             ^ ^^ ^  string.unquoted.makefile
#             ^^^^^^  meta.function-call.arguments.makefile


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
#                 ^^  string.unquoted.makefile

# ------------------------- line-cont. ------------------------ #

vC= $(if t\
          ,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#         ^^^^        meta.scope.expansion.makefile
#        ^ ^ ^        string.unquoted.makefile
#        ^^^^^        meta.function-call.arguments.makefile

vD= $(if \
         t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#        ^ ^ ^        string.unquoted.makefile
#         ^^^^        meta.scope.expansion.makefile

vE= $(if t\
,y,n)
#<-                   punctuation.separator.delimiter.comma.function.makefile
#^ ^                  string.unquoted.makefile

vF= $(if \\\
         t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#        ^ ^ ^        string.unquoted.makefile
#         ^^^^        meta.scope.expansion.makefile

vG= $(if \\ \
         t,y,n)
#         ^ ^         punctuation.separator.delimiter.comma.function.makefile
#        ^ ^ ^        string.unquoted.makefile
#         ^^^^        meta.scope.expansion.makefile

vF= $(if \\\
         t,y,n)
#         ^^^^        meta.scope.expansion.makefile

vG= $(if \\ \
         t,y,n)
#         ^^^^        meta.scope.expansion.makefile

vDd=$(dir \
         ddd)
#        ^^^          string.unquoted.makefile


# --------------------------- hashes -------------------------- #

func0 := $(if ,,a #b  )     ## /^\Qfunc0 := a #b  /
#                 ^       - comment.line.number-sign.makefile
#        ^^                 punctuation.definition.template-expression.begin.makefile
#                     ^     punctuation.definition.template-expression.end.makefile
#          ^^^^^^^^^^^      meta.function-call.makefile
#          ^^^^^^^^^^^      meta.scope.expansion.makefile
#               ^^^^        string.unquoted.makefile
#               ^^^^        meta.function-call.arguments.makefile
#            ^            - string.unquoted.makefile
#            ^            - meta.function-call.arguments.makefile

func1 := $(if ,,a\#b  )     ## /^\Qfunc1 := a\#b  /
#                ^        - constant.character.escape.backslash.makefile
#                 ^       - meta.escaped-char.makefile
#                 ^       - comment.line.number-sign.makefile
#        ^^                 punctuation.definition.template-expression.begin.makefile
#                     ^     punctuation.definition.template-expression.end.makefile
#          ^^^^^^^^^^^      meta.function-call.makefile
#          ^^^^^^^^^^^      meta.scope.expansion.makefile
#               ^^^^        string.unquoted.makefile
#               ^^^^        meta.function-call.arguments.makefile

func2 := $(dir  a\#b  )
#                 ^       - comment.line.number-sign.makefile


# ---------------------------- misc --------------------------- #

# space must follow after the function name for a built-in function to be recognized:
_tst0V := x$(if,T,f)y  ## /^\Q_tst0V := xy/

# test it:
_tst0T := x$(if,T,f)y
#         ^         ^       string.unquoted.makefile
#            ^^^^^^         variable.other.makefile
#            ^^^^^^         meta.scope.expansion.makefile
#            ^^           - support.function.if.makefile
#            ^^^^^^       - meta.function-call.makefile
#            ^^^^^^       - string.unquoted.makefile
#            ^^^^^^       - meta.function-call.arguments.makefile

_tst1T := x$(dir)y
#         ^      ^          string.unquoted.makefile
#            ^^^            variable.other.makefile
#            ^^^            meta.scope.expansion.makefile
#            ^^^          - support.function.dir.makefile


# ----------------- not recognized in comment ----------------- #

# NOT in $(if a,bc)
#          ^^^^^^^   - meta.scope.expansion.makefile
#          ^^        - support.function.if.makefile

# NOT in $(dir cmt)
#          ^^^^^^^   - meta.scope.expansion.makefile
#          ^^^       - support.function.dir.makefile
#          ^^^^^^^   - meta.function-call.makefile
#        ^^^^^^^^^^  - punctuation.definition.template-expression.begin.makefile
#        ^^^^^^^^^^  - punctuation.definition.template-expression.end.makefile
#        ^^^^^^^^^^  - punctuation.definition.variable.makefile
