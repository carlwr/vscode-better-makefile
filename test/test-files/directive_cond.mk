# SYNTAX TEST "source.makefile"


ifeq (a,A)
#^^^             keyword.control.ifeq.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile


# -------------------------- variants ------------------------- #

ifneq (neq,)
#^^^^            keyword.control.ifneq.makefile
endif

ifdef  def
#^^^^            keyword.control.ifdef.makefile
endif

ifndef ndef
#^^^^^           keyword.control.ifndef.makefile
endif


# ---------------------------- else --------------------------- #

ifeq (xxx,)
#^^^             keyword.control.ifeq.makefile
else
#^^^             keyword.control.else.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile

ifeq (yyy,)
#^^^             keyword.control.ifeq.makefile
yyy = YYY
#^^^^^^^^        meta.expression.assignment.makefile
else
#^^^             keyword.control.else.makefile
zzz = ZZZ
#^^^^^^^^        meta.expression.assignment.makefile
endif
#^^^^            keyword.control.endif.makefile
endif
#^^^^          - keyword.control.endif.makefile
