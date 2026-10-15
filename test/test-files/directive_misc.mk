# SYNTAX TEST "source.makefile"

export FOO=bar
#^^^^^              keyword.control.export.makefile

export FO:=bar
#^^^^^              keyword.control.export.makefile

# lone `export` allowed per GNU make manual:
export
#^^^^^              keyword.control.export.makefile

export fux baz
#^^^^^              keyword.control.export.makefile
#      ^^^          variable.other.makefile
#          ^^^      variable.other.makefile

  export f:x b:z
#  ^^^^^            keyword.control.export.makefile
#        ^^^        variable.other.makefile
#            ^^^    variable.other.makefile

override ab = AB
#^^^^^^^            keyword.control.override.makefile

override ab:= AB
#^^^^^^^            keyword.control.override.makefile

private  ef = EF
#^^^^^^             keyword.control.private.makefile

private  ef:= EF
#^^^^^^             keyword.control.private.makefile

unexport xxx
#^^^^^^^            keyword.control.unexport.makefile
#        ^^^        variable.other.makefile

# lone `unexport` allowed per GNU make manual:
unexport
#^^^^^^^            keyword.control.unexport.makefile


undefine yyy
#^^^^^^^            keyword.control.undefine.makefile
#        ^^^        variable.other.makefile

# valid per GNU Make manual (no entry in make db so can't use a parse test):
override undefine ovrUnd
#^^^^^^^                  keyword.control.override.makefile
#        ^^^^^^^^         keyword.control.undefine.makefile
#                 ^^^^^^  variable.other.makefile

override undefine ov:Und
#^^^^^^^                  keyword.control.override.makefile
#        ^^^^^^^^         keyword.control.undefine.makefile
#                 ^^^^^^  variable.other.makefile
