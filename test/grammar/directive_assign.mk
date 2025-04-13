# SYNTAX TEST "source.makefile"

export   BAR = bar
#            ^       keyword.operator.assignment.makefile
#        ^^^^^^^^^   meta.expression.assignment.makefile
#        ^^^         variable.other.assignment.makefile

export   TGHT=tght
#            ^       keyword.operator.assignment.makefile
#        ^^^^^^^^^   meta.expression.assignment.makefile
#        ^^^^        variable.other.assignment.makefile


override FOO = foo
#            ^       keyword.operator.assignment.makefile
#        ^^^^^^^^^   meta.expression.assignment.makefile
#        ^^^         variable.other.assignment.makefile


# -------- directives where assignment may _not_follow -------- #

ifdef    ifd=IFD
#           ^     - keyword.operator.assignment.makefile
endif

undefine und=UND
#           ^     - keyword.operator.assignment.makefile

include  inc=INC
#           ^     - keyword.operator.assignment.makefile

unexport une=UNE
#           ^     - keyword.operator.assignment.makefile

vpath    vpa=VPA
#           ^     - keyword.operator.assignment.makefile
