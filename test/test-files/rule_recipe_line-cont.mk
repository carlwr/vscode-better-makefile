# SYNTAX TEST "source.makefile"


cont:
	first \
#^^^^^     meta.scope.recipe.makefile

# continued line begins with a tab:
CONT:
	sec \
	ond#cmt
#^^^^^^^   meta.scope.recipe.makefile
#   ^^^^ - comment.line.number-sign.makefile

# continued line begins with a whitespace:
CONT2:
	sec \
 ond#cmt
#^^^^^^^   meta.scope.recipe.makefile
