# SYNTAX TEST "source.makefile"

# directive names do not track expansions: a name is cut at the first space
# or `#`, also within an expansion

export   $(sort b a)
#          ^^^^             support.function.sort.makefile
#          ^^^^^^^^         meta.scope.expansion.makefile

unexport $(sort b a)
#          ^^^^             support.function.sort.makefile
#          ^^^^^^^^         meta.scope.expansion.makefile

w := defined
undefine $(firstword w x)
#          ^^^^^^^^^        support.function.firstword.makefile
#          ^^^^^^^^^^^^^    meta.scope.expansion.makefile
w ?= undefined
## /^w = undefined$/

ifdef    $(firstword w x)
#          ^^^^^^^^^        support.function.firstword.makefile
#          ^^^^^^^^^^^^^    meta.scope.expansion.makefile
endif


# ------------------ `#` within an expansion ------------------ #

u := defined
v := u\#
undefine $(v:#=)
#            ^^^          - comment.line.number-sign.makefile
u ?= undefined
## /^u = undefined$/
