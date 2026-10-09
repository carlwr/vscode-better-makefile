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
#^^^^^^^^^^^^      meta.scope.target.makefile
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

var0  = .PHONY
#       ^^^^^^   - support.function.target.PHONY.makefile
var0 := .PHONY
#       ^^^^^^   - support.function.target.PHONY.makefile
tf $(or .PHONY ,): p
#       ^^^^^^   - support.function.target.PHONY.makefile
t: $(or .PHONY ,)
#       ^^^^^^   - support.function.target.PHONY.makefile


# ------------------------- in prereqs ------------------------ #

t:    .PHONY
#     ^^^^^^           support.function.target.PHONY.makefile
t____:.PHONY
#     ^^^^^^           support.function.target.PHONY.makefile
t:    .PHONY #c
#     ^^^^^^           support.function.target.PHONY.makefile
t:  x .PHONY y
#     ^^^^^^           support.function.target.PHONY.makefile
t: $c .PHONY y
#     ^^^^^^           support.function.target.PHONY.makefile
t: \
      .PHONY
#     ^^^^^^           support.function.target.PHONY.makefile
t: \
.PHONY
#^^^^^                 support.function.target.PHONY.makefile
t: \
 .PHONY # space-indented
#^^^^^^                support.function.target.PHONY.makefile
t: \
	.PHONY # tab-indented
#^^^^^^                support.function.target.PHONY.makefile


# negatives:

t:____x.PHONY
#      ^^^^^^        - support.function.target.PHONY.makefile
t:     .PHONYx
#      ^^^^^^        - support.function.target.PHONY.makefile
t:   # .PHONY x
#      ^^^^^^        - support.function.target.PHONY.makefile
t: p # .PHONY x
#      ^^^^^^        - support.function.target.PHONY.makefile


# should not be scoped as a .PHONY - but not serious enough to warrant an active test or XFAIL at this point:
t: v = .PHONY
