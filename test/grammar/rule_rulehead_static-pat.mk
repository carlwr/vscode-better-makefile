# SYNTAX TEST "source.makefile"

# static pattern rules:

__f0  f1 : f% : p%
# ^^  ^^            entity.name.function.target.makefile
# ^^^^^^^           meta.scope.target.makefile
#               ^^  meta.scope.prerequisites.makefile
# ^^^^^^^^^^^^^^^^  meta.scope.rulehead.makefile
