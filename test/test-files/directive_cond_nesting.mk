# SYNTAX TEST "source.makefile"

##
## all below verified as actual GNU make behaviour
##

ifneq (aaa,)
else ifeq (AAA,)
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile

ifneq (bbb,)
  ifeq (BBB,)
  endif
# ^^^^^          keyword.control.endif.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile

ifneq (c:c,)
#^^^^            keyword.control.ifneq.makefile
  ifeq (C:C,)
# ^^^^           keyword.control.ifeq.makefile
		else
# ^^^^           keyword.control.else.makefile
  endif
# ^^^^^          keyword.control.endif.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile

ifneq (ddd,)
else
  ifeq (DDD,)
  endif
# ^^^^^          keyword.control.endif.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile


# ---------------- similar, without indentation --------------- #

ifneq (eee,)
else
ifeq (EEE,)
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile
