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

varD =str
#<-         - string.unquoted
#^^^^^      - string.unquoted
#<-         - meta.string
#^^^^^      - meta.string

varE =st#c
#<-           meta.expression.assignment.makefile
#^^^^^^^      meta.expression.assignment.makefile


# for raw strings, such as RHS in assignment, a backslash can quote:
# - \#
# - \<nl> (line cont.)
# - itself for the two forms above

_esc0 = a\#b      ## /\Q_esc0 = a#b/
#        ^           constant.character.escape.backslash.makefile
_esc2 = a\\#b     ## /\Q_esc2 = a/
#        ^           constant.character.escape.backslash.makefile
_esc1 = a\
b                 ## /\Q_esc1 = a b/
