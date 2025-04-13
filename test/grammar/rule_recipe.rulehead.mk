# SYNTAX TEST "source.makefile"


tg_:_pr_;_recp
#^^^^^^^^^^^^^   meta.scope.rulehead.makefile
#^^              meta.scope.targets.makefile
#^^              entity.name.function.target.makefile
#  ^             punctuation.separator.key-value.rulehead.makefile
#   ^^^^         meta.scope.prerequisites.makefile
#       ^        punctuation.separator.key-value.rulehead.recipe.makefile
#        ^^^^^   meta.scope.recipe.makefile
tg : pr ; r cp
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
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
tg : pr ; r#cp
#   ^^^^         meta.scope.prerequisites.makefile
#        ^^^^^   meta.scope.recipe.makefile
#          ^^^ - comment.line.number-sign.makefile


$(a;b):$(a;);rc
#^^^^^           meta.scope.targets.makefile
#      ^^^^^     meta.scope.prerequisites.makefile
#            ^^  meta.scope.recipe.makefile

all:;rec
#^^              meta.scope.targets.makefile
#    ^^^         meta.scope.recipe.makefile

all:;rec
	rec
#^^^             meta.scope.recipe.makefile

all:;rec\
#    ^^^         meta.scope.recipe.makefile
all:;rec\
rec
#^^              meta.scope.recipe.makefile


# recipe line prefixes
# --------------------

lp0:; @cmd
#     ^          keyword.control.recipe-lineprefix.makefile
#    ^^^^^       meta.scope.recipe.makefile

lp1:;	 +	 @ +@ cmd
#      ^  ^ ^^   keyword.control.recipe-lineprefix.makefile
#    ^^^^^^^^^^^ meta.scope.recipe.makefile

lp1:; -cmd\
	+cmd
#^             - keyword.control.recipe-lineprefix.makefile

