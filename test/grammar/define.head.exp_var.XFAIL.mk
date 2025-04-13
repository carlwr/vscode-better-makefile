# SYNTAX TEST "source.makefile"

# currently, expansions are not performed for the var name in the define head - this grammar deficiency is accepted for the moment.

nmeA := varA
define $(nmeA)
#        ^^^^     variable.other.makefile
#      ^^    ^    punctuation.definition.variable.makefile
endef
## /^(define )?varA(?(1)$|( =))/

nmeB := varB
define $(nmeB) =
#        ^^^^     variable.other.makefile
#      ^^    ^    punctuation.definition.variable.makefile
endef
## /^(define )?varB(?(1)$|( =))/
