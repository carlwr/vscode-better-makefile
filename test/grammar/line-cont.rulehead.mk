# SYNTAX TEST "source.makefile"


# --------------------------- rules --------------------------- #

cannot-test_A \
_______targ_B: pre
# `cannot-test_A`:
#   can't test -> check manually
#   should be scoped as:
#     entity.name.function.target.makefile
#     meta.scope.targets.makefile

targ0_A \
targ0_B: pre
#^^^^^^       entity.name.function.target.makefile
#^^^^^^       meta.scope.targets.makefile
#        ^^^  meta.scope.prerequisites.makefile
#
## /targ0_A: pre/
## /targ0_B: pre/

targ1:\
 pre
#^^^       meta.scope.prerequisites.makefile
#^^^     - entity.name.function.target.makefile
#
## /targ1: pre/

targ2: pre2_A \
pre2_B
#^^^^^       meta.scope.prerequisites.makefile
#^^^^^     - entity.name.function.target.makefile
#
## /targ2: pre2_A pre2_B/

targ3: pre3_A \
pre3_B \
pre3_C
#^^^^^       meta.scope.prerequisites.makefile
#^^^^^     - entity.name.function.target.makefile
#
## /targ3: pre3_A pre3_B pre3_C/

targ4:\
 pre
	rec
#^^^       meta.scope.recipe.makefile


# ------------------------- impossible ------------------------ #

# these can be scoped correctly:
 t5        : pre
 t5     u5 : pre
 t5$(if ,,): pre

# but these _can't_ - not easily possible with textMate:
 t6     \
           : pre
 t6     \
        u6 : pre
 t6$(if \
        ,,): pre
