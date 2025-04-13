# SYNTAX TEST "source.makefile"

one:
	cmd
#^^^       meta.scope.recipe.makefile

two:
	vax
	vox
#^^^       meta.scope.recipe.makefile

with: dp
	foo
#^^^       meta.scope.recipe.makefile

a b: c d
	fox
#^^^       meta.scope.recipe.makefile

t: p; cmd
	fox
#^^^       meta.scope.recipe.makefile


%.o: %.c
	gcc -f
#^^^^^^    meta.scope.recipe.makefile

t: p
	a$(b)c
#^^^^^^    meta.scope.recipe.makefile
#   ^      variable.other.makefile

bar: b
#^^^^^   - meta.scope.recipe.makefile
#<-      - meta.scope.recipe.makefile


# don't scope comments in recipes
# -------------------------------

cmt0:
	c # cm 
#^^^^^^    meta.scope.recipe.makefile
#^^^^^^  - comment.line.number-sign.makefile

cmt1:
	#_cmt_ 
#^^^^^^    meta.scope.recipe.makefile
#^^^^^^  - comment.line.number-sign.makefile


# recipe line prefixes
# --------------------

linepref0:
	@cmd
#^^^^     meta.scope.recipe.makefile
#^        keyword.control.recipe-lineprefix.makefile
# ^^^   - keyword.control.recipe-lineprefix.makefile

linepref1:
	-cmd
	+cmd
#^        keyword.control.recipe-lineprefix.makefile

# `make` allows any sequence of lineprefix chars, spaces and tabs between the the initial tab and the command, and will recognize any lineprefix chars in that sequence (ref.: experiments):
linepref2:
	  +	 @ +@@- cmd
#  ^  ^ ^^^^     keyword.control.recipe-lineprefix.makefile
#^^^^^^^^^^^^^^^ meta.scope.recipe.makefile

linepref3:
	cmd\
	@
#^             - keyword.control.recipe-lineprefix.makefile

# with substref; not mistaken
# ---------------------------

trec0:
	rec $(a:A%=%)
#^^^^^^^^^^^^^   meta.scope.recipe.makefile
trec1:
	rec $(a=A)
#^^^^^^^^^^      meta.scope.recipe.makefile
