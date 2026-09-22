# SYNTAX TEST "source.makefile"

# the define head does not track expansions: the name is cut at the first
# space, so the rest of the expansion goes unscoped

define $(sort b a)
#        ^^^^        support.function.sort.makefile
#        ^^^^^^^^    meta.scope.expansion.makefile
#      ^^        ^   punctuation.definition.variable.makefile
yes
endef
## /^(define )?a b(?(1)$|( =))/
