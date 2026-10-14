# SYNTAX TEST "source.makefile"

ifeq (a,b)
else  ifdef X
#^^^                  keyword.control.else.makefile
#           ^         variable.other.makefile
else	ifneq (a,b)
#^^^                  keyword.control.else.makefile
endif

# make: "extraneous text after 'else' directive"
ifeq (a,b)
else ifdefx
#^^^                  keyword.control.else.makefile
#    ^^^^^^         - keyword.control.else.makefile
endif
