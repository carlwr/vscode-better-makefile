# SYNTAX TEST "source.makefile"

xxx = XXX
#   ^       keyword.operator.assignment.makefile
#<-         meta.expression.assignment.makefile
#^^^^^^^^   meta.expression.assignment.makefile
#<-         variable.other.assignment.makefile
#^^         variable.other.assignment.makefile
#  ^^^^^^  -variable.other.assignment.makefile

# current behaviour is to continue meta.expression over the comment - keep that at least for now:
xx2 = X#X
#   ^       keyword.operator.assignment.makefile
#      ^^   comment.line.number-sign.makefile
#^^^^^^^^   meta.expression.assignment.makefile

yy1 = y Y
#   ^       keyword.operator.assignment.makefile

x& := XXX
#  ^^       keyword.operator.assignment.makefile

x_&:= XXX
#  ^^       keyword.operator.assignment.makefile

xx := XXX
#  ^^       keyword.operator.assignment.makefile


abcd=ABCD
#   ^       keyword.operator.assignment.makefile
#<-         meta.expression.assignment.makefile
#^^^^^^^^   meta.expression.assignment.makefile
#<-         variable.other.assignment.makefile
#^^^        variable.other.assignment.makefile

efg = E=F   ## /^efg = E=F/
#   ^       keyword.operator.assignment.makefile
#      ^  - keyword.operator.assignment.makefile
#<-         meta.expression.assignment.makefile
#^^^^^^^^   meta.expression.assignment.makefile
#<-         variable.other.assignment.makefile
#^^         variable.other.assignment.makefile

hijk=HI=K   ## /^hijk = HI=K/
#   ^       keyword.operator.assignment.makefile
#      ^  - keyword.operator.assignment.makefile
#<-         meta.expression.assignment.makefile
#^^^^^^^^   meta.expression.assignment.makefile
#<-         variable.other.assignment.makefile
#^^^        variable.other.assignment.makefile

# GNU make hangs when queried for the make db of this file if this line is active:
# excl!!=ex   /^excl! != ex/


name\=val   ## /\Qname\ = val/
#^^^^       variable.other.assignment.makefile
#    ^      keyword.operator.assignment.makefile

# note: these are not valid assignments; is a parse error with `make`:
#
#     ha\#sh = val
#     h\\#sh = val

var = abc
vpath
#^^^^     - meta.expression.assignment.makefile


# combined tests: LHS exp. + operator variants
# --------------------------------------------

$(c)$(d)   != v
#          ^^           keyword.operator.assignment.makefile
$(c)var_   += v
#          ^^           keyword.operator.assignment.makefile
$(c)$cr_   ?= v
#          ^^           keyword.operator.assignment.makefile
$(or ,)_  ::= v
#         ^^^           keyword.operator.assignment.makefile
$(a:%=b) :::= v
#        ^^^^           keyword.operator.assignment.makefile


# not mistaken
# ------------

var = val
#^^^^^^^^               meta.expression.assignment.makefile
var = val # not: rule
#^^^^^^^^               meta.expression.assignment.makefile
var = $(aaa=AAA)str
#^^^^^^^^               meta.expression.assignment.makefile
var = $(exp:a=A)str
#^^^^^^^^               meta.expression.assignment.makefile
var = $(or $(exp:a=A)\
#^^^^^^^^               meta.expression.assignment.makefile
) # close scope
var = $(or $(exp:a=A)\
          ,Y,n)str
#         ^^^^^^^^      meta.expression.assignment.makefile


# parse error -> must have last in test
# -------------------------------------

# (nothing after the below will make it into the make database)

xx#3 = XXX
# ^^^^^^^   comment.line.number-sign.makefile
#^^^^^^^^ - meta.expression.assignment.makefile


# LHS detection heuristics
# ------------------------

$$$(c$$=)__$(v= )$c$  := v
#                     ^^     keyword.operator.assignment.makefile
$(#$c :=)__$(v${w=})  := v
#                     ^^     keyword.operator.assignment.makefile
$(v$(=%))__$(${})___  := v
#                     ^^     keyword.operator.assignment.makefile
$(___$(x)__$(y____)_c)!= v
#                     ^^     keyword.operator.assignment.makefile
$(___$(x)__${y$(x)}_c)+= v
#                     ^^     keyword.operator.assignment.makefile
$(___$(x)__${y$(x)}$c)?= v
#                     ^^     keyword.operator.assignment.makefile
$(___$(x)__${y$(x)}$$):= v
#                     ^^     keyword.operator.assignment.makefile

# negatives (since whitespace):
$$$(c$$=)  $(v= )$c$  := v
#                     ^^   - keyword.operator.assignment.makefile
$(#$c :=)  $(v${w=})  := v
#                     ^^   - keyword.operator.assignment.makefile
$(v$(=%))  $(${})___  := v
#                     ^^   - keyword.operator.assignment.makefile


# keep for reference/visual inspection:
#   should maybe match:
$(__$(x)${y$(x_}_)}_c_)___ :::= v
$(__$(x)${y$(x___{__)}_c_) :::= v
$(__$(x)${y$(x${_{_})}_c_) :::= v
#   should not match:
$(__$(x)${y$(x})_c_)______ :::= v
$(__$(x)${y$(x_)_)}_c_)___ :::= v

