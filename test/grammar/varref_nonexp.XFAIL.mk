# SYNTAX TEST "source.makefile"

# known to be a reference to a variable, but not a variable expansion

v := $(flavor var)
#             ^^^ variable.other.makefile
v := $(origin var)
#             ^^^ variable.other.makefile
v := $(value  var)
#             ^^^ variable.other.makefile
ifdef         var
#             ^^^ variable.other.makefile
endif

export var
#      ^^^ variable.other.makefile
