# SYNTAX TEST "source.makefile"


SHELL := true
  # so that nothing meaningful can be executed as a shell command


define d1 !=
#^^^^^          meta.shell-command.makefile
#^^^^^        - string.unquoted.makefile
endef
