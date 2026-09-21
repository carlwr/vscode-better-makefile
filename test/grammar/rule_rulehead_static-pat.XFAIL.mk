# SYNTAX TEST "source.makefile"

# static pattern rules - ideally should have these scopes:

__f0  f1 : f% : p%
#          ^^       entity.name.function.target.makefile
# ^^^^^^^  ^^       meta.scope.target.makefile
#               ^^  meta.scope.prerequisites.makefile
#          ^^     - meta.scope.prerequisites.makefile
