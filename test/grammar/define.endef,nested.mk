# SYNTAX TEST "source.makefile"


# note: make tracks nested define-s, and prints an error if the endef-s don't balance


define FOO
endef
#^^^^        keyword.control.endef.makefile
#^^^^      - keyword.control.override.makefile

define BAR
endef # cmt
#     ^^^^^  comment.line.number-sign.makefile


define b
define c
#^^^^^       keyword.control.define.makefile
#      ^     variable.other.assignment.makefile
  inner
endef
#^^^^        keyword.control.endef.makefile
endef
#^^^^        keyword.control.endef.makefile


# spurious endef
# --------------

define sp0
endef
endef
#^^^^      - keyword.control.endef.makefile


# first make sure we are on track again before next test:
define sp_
#^^^^^       keyword.control.define.makefile
endef
#^^^^        keyword.control.endef.makefile


# spurious endef with nested defines:
define spA
define spB
  inner
endef
#^^^^        keyword.control.endef.makefile
endef
#^^^^        keyword.control.endef.makefile
endef
#^^^^      - keyword.control.endef.makefile

