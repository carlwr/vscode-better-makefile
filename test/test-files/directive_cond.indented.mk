# SYNTAX TEST "source.makefile"

myVar := value


ifdef myVar

  var = spaces
# ^^^^^^^^^^^^    meta.expression.assignment.makefile
# ^^^^^^^^^^^^  - meta.scope.recipe.makefile


# rule within conditional
# -----------------------

targ0: pre
#^^^^             entity.name.function.target.makefile

targ1:
	v = tab
#^^^^^^^          meta.scope.recipe.makefile
#^^^^^^^        - meta.expression.assignment.makefile

endif
