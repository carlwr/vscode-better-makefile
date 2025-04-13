# SYNTAX TEST "source.makefile"


# plain
#<-        punctuation.definition.comment.makefile
#<-        comment.line.number-sign.makefile
#^^^^^^    comment.line.number-sign.makefile


   # spc
#<-        punctuation.whitespace.comment.leading.makefile
#^^        punctuation.whitespace.comment.leading.makefile
#  ^       punctuation.definition.comment.makefile
#  ^^^^^   comment.line.number-sign.makefile
#^^      - comment.line.number-sign.makefile


## /^t: p$/
t: p#cmt
#   ^      punctuation.definition.comment.makefile
#   ^^^^   comment.line.number-sign.makefile


## /^a = aa$/
a = aa#cm
#     ^    punctuation.definition.comment.makefile
#     ^^^  comment.line.number-sign.makefile

## /^b = b#b$/
b = b\#b
#     ^  - punctuation.definition.comment.makefile
#     ^^ - comment.line.number-sign.makefile


vpath#cmtAB = ab
#    ^^^^^^^^^^^   comment.line.number-sign.makefile
#^^^^              keyword.control.vpath.makefile

v = $(#)
#     ^^  - comment.line.number-sign.makefile


# these lines would be illegal:
#
#   "target#isCmt : prereq"
#   "name__#isCmt = value"
#
# ...since # starts a comment and lines "target", "name__" is not legal syntax
