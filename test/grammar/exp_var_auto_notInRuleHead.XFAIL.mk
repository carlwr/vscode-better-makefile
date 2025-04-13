# SYNTAX TEST "source.makefile"

xxxx: $@x
#      ^     - variable.parameter.automatic.makefile

XXX: $(@)X
#      ^     - variable.parameter.automatic.makefile

y$@y: yyyy
# ^          - variable.parameter.automatic.makefile
