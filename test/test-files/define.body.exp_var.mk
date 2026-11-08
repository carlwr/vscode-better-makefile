# SYNTAX TEST "source.makefile"


define basic
$(var)
# ^^^               variable.other.makefile
str$(subst ,,)
#    ^^^^^          support.function.subst.makefile
std$@
#   ^               variable.parameter.automatic.makefile
endef


define def1a
$(firstLine)
# ^^^^^^^^^          variable.other.makefile
endef


define def1b
$(firstLine)
$(secndLine)
# ^^^^^^^^^          variable.other.makefile
endef


define def1b
 # $(after-hash)
#    ^^^^^^^^^^      variable.other.makefile
 # $(after-hash)
#    ^^^^^^^^^^      variable.other.makefile
endef


define def2 # first an empty line:

$(secndLine)
# ^^^^^^^^^          variable.other.makefile
endef


define def3

 $(spc) # space-ind.
#  ^^^               variable.other.makefile

	$(tab) # tab-ind.
#  ^^^               variable.other.makefile
#^^   ^              punctuation.definition.variable.makefile

endef


# with override:
override define ovr
$(__ovr)
# ^^^^^              variable.other.makefile
endef
