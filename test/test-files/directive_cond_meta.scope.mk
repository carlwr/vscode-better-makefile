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

ifeq (a,b)
else  ifdef X
xdef:=yes
#^^^^^^^^        meta.scope.conditional.makefile
else	ifneq (a,b)
endif


# ------------------------- condition ------------------------- #

ifeq (a,b)
#    ^^^^^      meta.scope.condition.makefile
endif

ifdef  d
#    ^^^        meta.scope.condition.makefile
endif

ifeq (a,b)
#    ^^^^^      meta.scope.condition.makefile
else  ifdef X
#           ^   meta.scope.condition.makefile
xdef:=yes
else	ifneq (a,)
#          ^^^^ meta.scope.condition.makefile
else ifndef N
#           ^   meta.scope.condition.makefile
endif

ifeq (e,f)
#^^^          - meta.scope.condition.makefile
neg = 1
#^^^^^^       - meta.scope.condition.makefile
else ifeq (g,h)
#^^^^^^^^     - meta.scope.condition.makefile
else # cmt
#^^^^^^^^^    - meta.scope.condition.makefile
endif
