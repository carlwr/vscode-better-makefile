# SYNTAX TEST "source.makefile"


main: CFLAGS = -g
#     ^^^^^^^^^^^    meta.expression.assignment.makefile
#     ^^^^^^         variable.other.assignment.makefile
#            ^       keyword.operator.assignment.makefile
#^^^^^^^^^^^^^^^^    meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile
#     ^^^^^^^^^^^  - meta.scope.prerequisites.makefile

main: var := _$c_
#     ^^^^^^^^^^^    meta.expression.assignment.makefile
#     ^^^            variable.other.assignment.makefile
#         ^^         keyword.operator.assignment.makefile
#^^^^^^^^^^^^^^^^    meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile
#     ^^^^^^^^^^^  - meta.scope.prerequisites.makefile

main: var := _;$c_
#     ^^^^^^^^^^^^   meta.expression.assignment.makefile
#     ^^^            variable.other.assignment.makefile
#         ^^         keyword.operator.assignment.makefile
#               ^    meta.scope.expansion.makefile
#              ^     punctuation.definition.variable.makefile
#^^^^^^^^^^^^^^^^^   meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile
#     ^^^^^^^^^^^^ - meta.scope.prerequisites.makefile

main:v=V
#    ^^^             meta.expression.assignment.makefile
#    ^^^           - meta.scope.prerequisites.makefile
#^^^^^^^             meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile

%.o: v=V
#    ^^^             meta.expression.assignment.makefile
#    ^^^           - meta.scope.prerequisites.makefile
#^^^^^^^             meta.scope.rulehead.makefile
#^^                  entity.name.function.target.makefile

main: v=$(v:%o=%c)
#     ^^^^^^^^^^^^   meta.expression.assignment.makefile
#     ^              variable.other.assignment.makefile
#          ^         support.function.substref.colon.makefile
#             ^      punctuation.separator.substref.equal.makefile
#^^^^^^^^^^^^^^^^^   meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile
#     ^^^^^^^^^^^^ - meta.scope.prerequisites.makefile



# negatives
# ---------

# assignment in a rulehead recipe should not be mistaken for a target-specific assignment:

main: p; var = val
#^^^^^^^^^^^^^^^^^   meta.scope.rulehead.makefile
#^^^                 entity.name.function.target.makefile
#     ^              meta.scope.prerequisites.makefile
#        ^^^^^^^^^   meta.scope.recipe.makefile
#        ^^^^^^^^^ - meta.scope.prerequisites.makefile
#        ^^^^^^^^^ - meta.expression.assignment.makefile
