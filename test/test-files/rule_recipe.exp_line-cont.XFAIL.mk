# SYNTAX TEST "source.makefile"


# \-s preceding <nl>, within an expansion: make keeps the pairs as-is
# (r: the default goal, so `make -n` prints its expanded recipe)
## /^echo r_eyp[\\]{2} b$/
r:
	echo $(subst x,y,r_exp\\\
	b)

r_:
	echo $(subst x,y,r_exp\\\
#                      ^^     - constant.character.escape.backslash.makefile
#                        ^      punctuation.separator.continuation.makefile
	b)
