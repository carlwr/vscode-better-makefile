# SYNTAX TEST "source.makefile"


tg_:_pr_;_recp
#^^^^^^^^^^^^^   meta.scope.rulehead.makefile
#^^              meta.scope.target.makefile
#^^              entity.name.function.target.makefile
#  ^             punctuation.separator.key-value.rulehead.makefile
#   ^^^^         meta.scope.prerequisites.makefile
#       ^        punctuation.separator.key-value.rulehead.recipe.makefile
#        ^^^^^   meta.scope.recipe.makefile
tg : pr ; r cp
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
#^^^^^^^^      - meta.scope.recipe.makefile
tg : pr ; r;cp
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
tg : pr ;$(e)p
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
#          ^     variable.other.makefile
tg : pr ; $ecp
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
#          ^     variable.other.makefile

$(a;b):$(a;);rc
#^^^^^           meta.scope.target.makefile
#      ^^^^^     meta.scope.prerequisites.makefile
#            ^^  meta.scope.recipe.makefile

all:;rec
#^^              meta.scope.target.makefile
#    ^^^         meta.scope.recipe.makefile

all:;rec
	rec
#^^^             meta.scope.recipe.makefile

all:;rec\
#    ^^^         meta.scope.recipe.makefile
all:;rec\
rec
#^^              meta.scope.recipe.makefile


# hashes in rulehead recipes are not comments
# -------------------------------------------

# FIRST, verify with parse tests (note: the make database writes recipes on separate tab-indented lines, even if the source file defines them in the rulehead):

# these two are equivalent:
t0a: pa; rec#ipe_a
t0A: pA
	 rec#ipe_A
## /^\t rec#ipe_a/
## /^\t rec#ipe_A/

# and these two are equivalent:
t0b: pb; rec #pe_b
t0B: pB
	 rec #pe_B
## /^\t rec #pe_b/
## /^\t rec #pe_B/

# THEN, verify with tests:

tg: pr; r#cp
#  ^^^              meta.scope.prerequisites.makefile
#      ^^^^^        meta.scope.recipe.makefile
#        ^^^      - comment.line.number-sign.makefile

tg: pr; r #p
#  ^^^              meta.scope.prerequisites.makefile
#      ^^^^^        meta.scope.recipe.makefile
#        ^^^      - comment.line.number-sign.makefile


# recipe line prefixes
# --------------------

lp0:; @cmd
#     ^             keyword.control.recipe-lineprefix.makefile
#    ^^^^^          meta.scope.recipe.makefile

lp1:;	 +	 @ +@ cmd
#      ^  ^ ^^      keyword.control.recipe-lineprefix.makefile
#    ^^^^^^^^^^^    meta.scope.recipe.makefile

lp2:; -cmd\
	+cmd
#^                - keyword.control.recipe-lineprefix.makefile

lp3:
	+cmd
#^                  keyword.control.recipe-lineprefix.makefile

lp3:
	+@cmd
#^^                 keyword.control.recipe-lineprefix.makefile
#<-               - keyword.control.recipe-lineprefix.makefile
#  ^^^            - keyword.control.recipe-lineprefix.makefile
