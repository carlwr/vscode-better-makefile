# SYNTAX TEST "source.makefile"


SHELL := true
  # so that nothing meaningful can be executed as a shell command


define d1 !=
echo p
#^^^^^          meta.shell-command.assignment.makefile
#^^^^^        - string.unquoted.makefile
endef
