# SYNTAX TEST "source.makefile"

# known to be a reference to a variable, but not a variable expansion

v := $(value  var)
#             ^^^ variable.other.makefile
