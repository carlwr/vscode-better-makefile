# SYNTAX TEST "source.makefile"

export FOO=bar
#^^^^^              keyword.control.export.makefile

export
#^^^^^              keyword.control.export.makefile

export fux baz
#^^^^^              keyword.control.export.makefile
#      ^^^          variable.other.makefile
#          ^^^      variable.other.makefile

override ab = AB
#^^^^^^^            keyword.control.override.makefile

private  ef = EF
#^^^^^^             keyword.control.private.makefile


unexport xxx
#^^^^^^^            keyword.control.unexport.makefile
#        ^^^        variable.other.makefile

undefine yyy
#^^^^^^^            keyword.control.undefine.makefile
#        ^^^        variable.other.makefile
