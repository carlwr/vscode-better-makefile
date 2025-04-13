# SYNTAX TEST "source.makefile"


include foo
#^^^^^^             keyword.control.include.makefile

   include a b
#  ^^^^^^^          keyword.control.include.makefile

-include opt
#^^^^^^^            keyword.control.include.makefile
#<-                 keyword.control.include.makefile

sinclude also
#^^^^^^^            keyword.control.include.makefile
#<-                 keyword.control.include.makefile
