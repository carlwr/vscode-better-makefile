# SYNTAX TEST "source.makefile"

nmeA := varA
define $(nmeA)
#        ^^^^     variable.other.makefile
#      ^^         punctuation.definition.template-expression.begin.makefile
#            ^    punctuation.definition.template-expression.end.makefile
endef
## /^(define )?varA(?(1)$|( =))/

nmeB := varB
define $(nmeB) =
#        ^^^^     variable.other.makefile
#      ^^         punctuation.definition.template-expression.begin.makefile
#            ^    punctuation.definition.template-expression.end.makefile
endef
## /^(define )?varB(?(1)$|( =))/

nmeC := varC
define ${nmeC}
#        ^^^^     variable.other.makefile
endef
## /^(define )?varC(?(1)$|( =))/

d := varD
define $d
#       ^         variable.other.makefile
endef
## /^(define )?varD(?(1)$|( =))/
