# SYNTAX TEST "source.makefile"

# a target-specific assignment is not recognized as an assignment at all

main: CFLAGS = -g
#     ^^^^^^   variable.other.assignment.makefile
#            ^ keyword.operator.assignment.makefile
