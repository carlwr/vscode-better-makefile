# SYNTAX TEST "source.makefile"

define aa1
vpath
#^^^^           - keyword.control.vpath.makefile
#^^^^             meta.scope.define.makefile
endef

define aa2#cmt
vpath
#^^^^           - keyword.control.vpath.makefile
#^^^^             meta.scope.define.makefile
endef

define aa2#cmt:=
vpath
#^^^^           - keyword.control.vpath.makefile
#^^^^             meta.scope.define.makefile
endef

define ccc
#cmt 1st line
#^^^^^^^^^^^^   - comment.line.number-sign.makefile
endef
var_ccc := $(ccc)  ## /^var_ccc := #cmt.*/


define ddd # first an empty line:

#cmt 2nd line
#^^^^^^^^^^^^   - comment.line.number-sign.makefile
endef


define eee
 #cmt space-ind
#^^^^^^^^^^^^^^ - comment.line.number-sign.makefile
endef
