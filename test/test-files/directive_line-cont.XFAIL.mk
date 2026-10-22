# SYNTAX TEST "source.makefile"

# line continuations in these directives are not recognized; the continued
# line goes unscoped

export   exA \
  ex
# ^^                variable.other.makefile

unexport unA \
  un
# ^^                variable.other.makefile

-include inA.mk \
  inB.mk
# ^^^^^^            string.unquoted.path.makefile

vpath %.lc \
  lcdir
# ^^^^^             string.unquoted.path.makefile
## /^vpath %.lc lcdir$/
