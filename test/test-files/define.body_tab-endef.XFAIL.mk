# SYNTAX TEST "source.makefile"


# a body line starting with a tab is never `endef`

define d_tab_
	endef
#^^^^^   - keyword.control.endef.makefile
#^^^^^     meta.scope.define.body.makefile
endef
#^^^^      keyword.control.endef.makefile

## /^d_tab = \tendef$/
define d_tab
	endef
endef
