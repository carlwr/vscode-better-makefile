# SYNTAX TEST "source.makefile"

ifeq (a,b)
var = val
#^^^^^^^^        meta.scope.conditional.makefile
endif

ifeq (a,b)
else
VAR = VAL
#^^^^^^^^        meta.scope.conditional.makefile
endif
xxx = yyy
#^^^^^^^^      - meta.scope.conditional.makefile
