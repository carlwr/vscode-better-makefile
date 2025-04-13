# SYNTAX TEST "source.makefile"

e = $(_$$_)

# ------------------- assignment RHS, prereq ------------------ #

a := __$$_       ## /^\Qa := __$$_  /
#      ^^        constant.character.escape.dollar.makefile
#      ^^      - meta.scope.expansion.makefile
a2 = __$$_       ## /^\Qa2 = __$$_  /
#      ^^        constant.character.escape.dollar.makefile
AAA: _p$$_       ## /^\QAAA: _p$_/
#      ^^        constant.character.escape.dollar.makefile

b =    $$
#      ^^        constant.character.escape.dollar.makefile
B :    $$
#      ^^        constant.character.escape.dollar.makefile
c =  __$$
#      ^^        constant.character.escape.dollar.makefile
c2=  _\$$
#      ^^        constant.character.escape.dollar.makefile
d =  $($$)
#      ^^        constant.character.escape.dollar.makefile
D :  $($$)
#      ^^        constant.character.escape.dollar.makefile
e = $(_$$_)
#      ^^        constant.character.escape.dollar.makefile


# ------------------- assignment LHS, target ------------------ #

a_$$_ = abc      ## /^\Qa_$_ = abc/
# ^^             constant.character.escape.dollar.makefile
b_$$_ : ABC      ## /^\Qb_$_: ABC/
# ^^             constant.character.escape.dollar.makefile
$$   = def
#<-              constant.character.escape.dollar.makefile
#^               constant.character.escape.dollar.makefile
$$   : DEF
#<-              constant.character.escape.dollar.makefile
#^               constant.character.escape.dollar.makefile


# ------------------- surrounding expansions ------------------ #

xx=    $$$(X)
#      ^^        constant.character.escape.dollar.makefile
#        ^     - constant.character.escape.dollar.makefile
#        ^^ ^    punctuation.definition.variable.makefile

yy=$(Y)$$
#      ^^        constant.character.escape.dollar.makefile


# ----------------- in func args, subst. ref.: ---------------- #

aa=$(if _arg$$,,)
#           ^^   constant.character.escape.dollar.makefile
bb=$(flavor $$)
#           ^^   constant.character.escape.dollar.makefile
cc=$(cccccc:$$=C)
#           ^^   constant.character.escape.dollar.makefile
dd=$(DD:EEE=$$)
#           ^^   constant.character.escape.dollar.makefile


# ------------------------ conditional ------------------------ #

ifdef _$$str
#      ^^        constant.character.escape.dollar.makefile
endif


# --------------------------- recipe -------------------------- #

target:
	t$$cmd
# ^^             constant.character.escape.dollar.makefile

goal:
	#$$g
# ^^             constant.character.escape.dollar.makefile

goal2:
	_$${SHELL}
# ^^             constant.character.escape.dollar.makefile
#    ^^^^^     - variable.language.readwrite.makefile


# --------------------- not misinterpreted -------------------- #

x1= _$$(X1)
#    ^^          constant.character.escape.dollar.makefile
#      ^  ^    - punctuation.definition.variable.makefile
#       ^^     - variable.other.makefile

x2= \$$(X1)
#    ^^          constant.character.escape.dollar.makefile
#      ^  ^    - punctuation.definition.variable.makefile
#       ^^     - variable.other.makefile

y1= _$$(if Y2,,)
#    ^^          constant.character.escape.dollar.makefile
#       ^^     - support.function

y2= Z$$@
#    ^^          constant.character.escape.dollar.makefile
#      ^       - variable.parameter.automatic.makefile

# \ before $ is not special:
var := VAL       ## prepare
z1_ := a\$(var)  ## /^\Qz1_ := a\VAL    /
#          ^^^   variable.other.makefile
#       ^^     - constant.character.escape.dollar.makefile

c := C
z := _\$c_       ##  /^\Qz := _\C_
#       ^        variable.other.makefile


# ------------------------- in comment ------------------------ #

# cmt $$
#     ^^       - constant.character.escape.dollar.makefile
