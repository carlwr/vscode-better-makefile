# SYNTAX TEST "source.makefile"


# with this line cont. ...

## /var1_ = val1__A val1__B$/
var1_ = val1__A \
 val1__B
#^^^^^^^        meta.expression.assignment.makefile


# ...make will first collapse the line, then remove comments:

## /var1a = val1a_A val1a_B$/
var1a = val1a_A \
 val1a_B#cmt
#       ^^^^    comment.line.number-sign.makefile

## /var1b = val1b_A$/
var1b = val1b_A#cmt\
 val1b_B
#^^^^^^^        comment.line.number-sign.makefile


# line cont. within comment
# -------------------------

# //--- prepare ---
that__2a := ORIG
still_2b := ORIG
# ---------------//

# with this simple assignment with a comment...

## /var2_ := val2_ $/
var2_ := val2_ #cmt

# ... line cont. can be made within the comment

## /var2a := val2a $/
var2a := val2a # cmt\
that__2a := continues
#^^^^^^^^^^^^^^^^^^^^     comment.line.number-sign.makefile

## /var2b := val2b $/
var2b := val2b #\
still_2b := a-comment
#^^^^^^^^^^^^^^^^^^^^     comment.line.number-sign.makefile

# //----- verify ------
#
#  ...that these were
#  not overwritten:
#
## /^that__2a := ORIG$/
## /^still_2b := ORIG$/
# -------------------//

v = v#\
cmt \
cmt
#^^      comment.line.number-sign.makefile

v = v#\
cmt \
c#t
#^^      comment.line.number-sign.makefile

v = v#\
cmt \
c\#t
#^^^     comment.line.number-sign.makefile

v = v\
u #cmt \
cmt
#^^     comment.line.number-sign.makefile
