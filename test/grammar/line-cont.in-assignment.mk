# SYNTAX TEST "source.makefile"


va = A  \
     B
#    ^         meta.expression.assignment.makefile
##             /va = A B/


vb = A\\\
     B
#    ^         meta.expression.assignment.makefile
##             /vb = A\\ B/


vc = A\\
     vpath
#    ^       - meta.expression.assignment.makefile
##             /vc = A\\\\$/


ve = A \
       \
     B
#    ^         meta.expression.assignment.makefile


# these would be equivalent:
v3a= A #cmt
#      ^^^^    comment.line.number-sign.makefile
v3b= A\
       #cmt
#      ^^^^    comment.line.number-sign.makefile
##             /v3a = A\s$/
##             /v3b = A\s$/

# verify scope for first line in the above forms:
v3c= A\
#^^^^^         meta.expression.assignment.makefile

