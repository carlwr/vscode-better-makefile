# SYNTAX TEST "source.makefile"

# an "else" may have another condition after it
# my understanding: is not a _nested_ conditional, i.e. the whole conditional is still closed with a single endif (TODO: verify)

ifeq (a,a)
else ifeq (A,A)
#    ^^^^       keyword.control.ifeq.makefile
#    ^^^^     - keyword.control.else.makefile
#^^^            keyword.control.else.makefile
endif
#^^^^           keyword.control.endif.makefile
endif
#^^^^         - keyword.control.endif.makefile


# additional "else", with or without condition after it:

ifeq (b,b)
else ifeq (B,B)
#    ^^^^       keyword.control.ifeq.makefile
#    ^^^^     - keyword.control.else.makefile
#^^^            keyword.control.else.makefile
else
#^^^            keyword.control.else.makefile
endif
#^^^^           keyword.control.endif.makefile
endif
#^^^^         - keyword.control.endif.makefile


ifeq (c,c)
else ifeq (C,C)
#    ^^^^       keyword.control.ifeq.makefile
#    ^^^^     - keyword.control.else.makefile
#^^^            keyword.control.else.makefile
else ifeq (CC,)
#    ^^^^       keyword.control.ifeq.makefile
#    ^^^^     - keyword.control.else.makefile
#^^^            keyword.control.else.makefile
else
#^^^            keyword.control.else.makefile
endif
#^^^^           keyword.control.endif.makefile
endif
#^^^^         - keyword.control.endif.makefile
