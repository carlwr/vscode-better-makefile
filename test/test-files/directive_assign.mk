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

private  FOO = foo
#            ^       keyword.operator.assignment.makefile
#        ^^^^^^^^^   meta.expression.assignment.makefile
#        ^^^         variable.other.assignment.makefile


# -------------------- not mislead by `:`-s ------------------- #

# check that directives that support assignments are not misinterpreted as e.g. ruleheads when a `:` is involved. For simplicity, use "the name of the assigned variable is correctly scoped" as a proxy for "probably not misinterpreted".

export   v := v_V
#        ^                 variable.other.assignment.makefile
override v := v_V
#        ^                 variable.other.assignment.makefile
private  v := v_V
#        ^                 variable.other.assignment.makefile

export   v =  v:V
#        ^                 variable.other.assignment.makefile
override v =  v:V
#        ^                 variable.other.assignment.makefile
private  v =  v:V
#        ^                 variable.other.assignment.makefile

export   v =  v__ # : _
#        ^                 variable.other.assignment.makefile
override v =  v__ # : _
#        ^                 variable.other.assignment.makefile
private  v =  v__ # : _
#        ^                 variable.other.assignment.makefile

export   v        # : _
#        ^                 variable.other.makefile
unexport v        # : _
#        ^                 variable.other.makefile
undefine v        # : _
#        ^                 variable.other.makefile


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
