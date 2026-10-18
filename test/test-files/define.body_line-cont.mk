# SYNTAX TEST "source.makefile"


# odd no. of \-s: line cont.; make halves the preceding \-s
## /^d_odd = a_odd [\\] b_odd$/
define d_odd
a_odd \\\
b_odd
endef

define d_odd_
a \\\
# ^^      constant.character.escape.backslash.makefile
#   ^     punctuation.separator.continuation.makefile
b
#<-       string.unquoted.makefile
endef


# even no. of \-s: no line cont., no escapes
## /^a_even [\\]{2}$/
define d_even
a_even \\
b_even
endef

define d_even_
a \\
# ^^    - constant.character.escape.backslash.makefile
# ^^    - punctuation.separator.continuation.makefile
# ^^      string.unquoted.makefile
endef
#^^^^     keyword.control.endef.makefile


# a continued line is not a directive
## /^d_endef = a_endef endef$/
define d_endef
a_endef \
endef
endef

define d_endef_
a \
endef
#^^^^   - keyword.control.endef.makefile
#^^^^     meta.scope.define.body.makefile
endef
#^^^^     keyword.control.endef.makefile

define d_define_
a \
define x
#^^^^^  - keyword.control.define.makefile
#^^^^^    string.unquoted.makefile
endef

define d_multi_
a \
b \
endef
#^^^^   - keyword.control.endef.makefile
endef
