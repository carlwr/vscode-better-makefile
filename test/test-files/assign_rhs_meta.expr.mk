# SYNTAX TEST "source.makefile"

varA  =str
#<-           meta.expression.assignment.makefile
#^^^^^^^^^    meta.expression.assignment.makefile

varB :=str
#<-           meta.expression.assignment.makefile
#^^^^^^^^^    meta.expression.assignment.makefile

varC:= str
#<-           meta.expression.assignment.makefile
#^^^^^^^^^    meta.expression.assignment.makefile

varE =st#c
#<-           meta.expression.assignment.makefile
#^^^^^^^      meta.expression.assignment.makefile
