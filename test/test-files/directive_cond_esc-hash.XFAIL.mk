# SYNTAX TEST "source.makefile"

# `\#` in an ifdef operand is an escaped hash, not a comment: the variable is
# named `FOO#bar` (see the parse assert below)

define FOO\#bar
yes
endef
ifdef FOO\#bar
#        ^       constant.character.escape.backslash.makefile
#         ^      meta.escaped-char.makefile
#          ^^^   variable.other.makefile
escapedHash := ok
endif
## /^escapedHash := ok/
