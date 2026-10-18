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



# with modifiers
# --------------

# valid: export, unexport, override, or private
# ref.: GNU make manual

## /^main: V = v$/
main: export V = v
#     ^^^^^^                    keyword.control.export.makefile
#     ^^^^^^^^^^^^              meta.expression.assignment.makefile

## /^main: W := w$/
main: unexport private W := w
#     ^^^^^^^^                  keyword.control.unexport.makefile
#              ^^^^^^^          keyword.control.private.makefile

# a variable named as a keyword:
## /^main: private = p$/
main: override private = p
#     ^^^^^^^^                  keyword.control.override.makefile
#              ^^^^^^^          variable.other.assignment.makefile

# no assignment, hence prerequisites:
## /^main: .*export X$/
main: export X
#     ^^^^^^^^                  meta.scope.prerequisites.makefile
#     ^^^^^^                  - keyword.control.export.makefile
