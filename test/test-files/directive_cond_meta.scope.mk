# SYNTAX TEST "source.makefile"


# ------------------------ conditional ------------------------ #

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


# ------------------------- condition ------------------------- #

ifeq (a,b)
#    ^^^^^      meta.scope.condition.makefile
endif

ifdef  d
#    ^^^        meta.scope.condition.makefile
endif
