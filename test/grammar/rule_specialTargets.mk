# SYNTAX TEST "source.makefile"

.PHONY:
#<-                support.function.target.PHONY.makefile
#^^^^^             support.function.target.PHONY.makefile
#     ^          - support.function.target.PHONY.makefile

.PHONY: prereq
#<-                support.function.target.PHONY.makefile
#^^^^^             support.function.target.PHONY.makefile
#     ^^^^^^^^   - support.function.target.PHONY.makefile
__targ .PHONY:p
#^^^^^^^^^^^^      meta.scope.targets.makefile
#^^^^^             entity.name.function.target.makefile
#      ^^^^^^      support.function.target.PHONY.makefile
.PHONY .PHONY:
#^^^^^ ^^^^^^      support.function.target.PHONY.makefile

.PHONY:
#^^^^^             support.function.target.PHONY.makefile
.PHONY:# cmt
#^^^^^             support.function.target.PHONY.makefile
  .PHONY: p
# ^^^^^^           support.function.target.PHONY.makefile
  .PHONY :p
# ^^^^^^           support.function.target.PHONY.makefile


# negatives
# ---------

   PHONY   : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile
  .PHON    : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile
 x.PHONY   : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile
  .PHONYx  : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile
$c.PHONY   : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile
  .PHONY$c : p
#^^^^^^^^^^      - support.function.target.PHONY.makefile

rec:
	.PHONY
#^^^^^^          - support.function.target.PHONY.makefile

.PHONY = value
#^^^^^^^^^^^^^   - support.function.target.PHONY.makefile
#<-              - support.function.target.PHONY.makefile

tf $(or .PHONY ,): p
#       ^^^^^^   - support.function.target.PHONY.makefile

# how treat built-in targets in prereqs? Most don't make sense as prereqs - but some, like .WAIT, _only_ make sense as prereqs. For now, no tests on this either way.
p:.PHONY   
