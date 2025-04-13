# SYNTAX TEST "source.makefile"


# just expansion
# --------------

# disabled:
$(a=b)
# ^^^            meta.scope.expansion.makefile
#^^^^^         - meta.expression.assignment.makefile
$(a=b)  # t:p
# ^^^            meta.scope.expansion.makefile
#^^^^^         - meta.expression.assignment.makefile
#^^^^^         - meta.scope.rulehead.makefile
 
$(aaa)  # t:p
#^^^^^^^^^^^^   - meta.scope.rulehead.makefile
$(a:_)  # t:p
#^^^^^^^^^^^^   - meta.scope.rulehead.makefile



$(FFF:%fnd=%rp)
#<-               punctuation.definition.variable.makefile
#^                punctuation.definition.variable.makefile
# ^^^             variable.other.makefile
#^^^^^^^^^^^^^^ - meta.scope.rulehead.makefile

$(if f,$(FFF:%fnd=%rpl),)
#           ^             punctuation.separator.substref.colon.makefile
#                ^        punctuation.separator.substref.equal.makefile
#            ^    ^       constant.other.placeholder.substref.percent.makefile
#            ^^^^^^^^^    meta.substref.makefile

$(or $(exp:a=A)\
    ,Y,n)


# just strings
# ------------

str\:ing
#^^^^^^^           - meta.scope.rulehead.makefile

str  # not : rule
#^^^^^^^^^^^^^^^^  - meta.scope.rulehead.makefile
str  # not = asgn
#^^^^^^^^^^^^^^^^  - meta.expression.assignment.makefile


# comments
# --------
# v = A
# t: p
# cmt \
  still = cmt
# cmt \
  still : cmt
# cmt \
  $(still) cmt
