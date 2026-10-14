# SYNTAX TEST "source.makefile"


# a body line starting with a tab never starts a nested define

define d_tab_
	define x
#^^^^^^  - keyword.control.define.makefile
#^^^^^^    string.unquoted.makefile
endef
v = 1
#<-        variable.other.assignment.makefile

## /^d_tab = \tdefine x$/
define d_tab
	define x
endef
