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


# \-s preceding <nl>: make passes them on to the shell as-is

## /^\techo r_odd[\\]{3}$/
r_odd:
	echo r_odd\\\
#          ^^     - constant.character.escape.backslash.makefile
	more
#^^^^               meta.scope.recipe.makefile

# (#cmt: in the make db, kept only if part of the recipe)
## /^v_r_even := after$/
r_even:
	echo r_even\\
v_r_even := after#cmt
#<-                 variable.other.assignment.makefile

r_even2:
	echo r_even\\
#           ^^    - constant.character.escape.backslash.makefile
#           ^^    - punctuation.separator.continuation.makefile

r_semi: ; echo r_semi\\\
#                    ^^   - constant.character.escape.backslash.makefile
	more
#^^^^                      meta.scope.recipe.makefile
