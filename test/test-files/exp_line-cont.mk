# SYNTAX TEST "source.makefile"


# in these tests the following is used:
#
#    -------------
#    # )})} #close   -> close any existing scopes for the grammar
#
#    )               -> close open brackets for VS Code bracket colors
#    -------------
#


# prep. sanity checks
# -------------------

$(var
#CMT)#cmt
#    ^^^^        comment.line.number-sign.makefile
)
$(v#)#cmt
#    ^^^^        comment.line.number-sign.makefile
# ^^             variable.other.makefile
${var$(VAR)}
# ^^^  ^^^       variable.other.makefile
#<-              punctuation.definition.template-expression.begin.makefile
#^   ^^          punctuation.definition.template-expression.begin.makefile
#         ^^     punctuation.definition.template-expression.end.makefile


# tests
# -----

$(var\
#    ^           punctuation.separator.continuation.makefile
# ^^^^           meta.scope.expansion.makefile
)
# )})} #close

$(\
# ^           punctuation.separator.continuation.makefile
)
# )})} #close


$(var\
#nme)#cmt
#^^^             variable.other.makefile
#^^^^          - comment.line.number-sign.makefile
# )})} #close

$(var\
#nme)#cmt
#^^^             variable.other.makefile
#    ^^^^        comment.line.number-sign.makefile
# )})} #close

${var\
#nme}#cmt
#^^^             variable.other.makefile
#^^^^          - comment.line.number-sign.makefile
#    ^^^^        comment.line.number-sign.makefile
# )})} #close

${var$(VAR\
#NME)#nme}#cmt
#^^^ ^^^^        variable.other.makefile
#^^^^^^^^^     - comment.line.number-sign.makefile
#         ^^^^   comment.line.number-sign.makefile

# )})} #close

$(v\
   ar$(VA\
         R\
          #NM\
             E)#nm\
                  #e)#cmt
#                 ^^        variable.other.makefile
#                    ^^^^ - variable.other.makefile
#                 ^^      - comment.line.number-sign.makefile
#                    ^^^^   comment.line.number-sign.makefile
# )})} #close

$(or\
#   ^           punctuation.separator.continuation.makefile
# ^^            support.function.or.makefile
)
# )})} #close


$(or \
#    ^           punctuation.separator.continuation.makefile
)
# )})} #close

$(or \
#arg)#cmt
#^^^^          - comment.line.number-sign.makefile
#    ^^^^        comment.line.number-sign.makefile
# )})} #close

${or \
#arg}#cmt
#^^^^          - comment.line.number-sign.makefile
#    ^^^^        comment.line.number-sign.makefile
# )})} #close

${or (_\
#      ^         punctuation.separator.continuation.makefile
)}
# )})} #close

${or (_\
_)#arg}#cmt
#^^^^^^        - comment.line.number-sign.makefile
#      ^^^^      comment.line.number-sign.makefile
# )})} #close

# odd no. of \-s: line cont., the others are escaped \-s
$(or _\\\
#       ^        punctuation.separator.continuation.makefile
#arg)#cmt
#^^^^          - comment.line.number-sign.makefile
#    ^^^^        comment.line.number-sign.makefile
# )})} #close

${or {_\\\
#        ^       punctuation.separator.continuation.makefile
_}#arg}#cmt
#^^^^^^        - comment.line.number-sign.makefile
#      ^^^^      comment.line.number-sign.makefile
# )})} #close


# ---------------------- nested functions --------------------- #


# use this as model:

$(or #$(or #)#)#c
#^^^^^^^^^^^^^^    - comment.line.number-sign.makefile
#              ^^    comment.line.number-sign.makefile


# then test variants with line cont.:

$(or \
     #$(or #)#)#c
#    ^^^^^^^^^^    - comment.line.number-sign.makefile
#              ^^    comment.line.number-sign.makefile

$(or #$(or \
           #)#)#c
#          ^^^^    - comment.line.number-sign.makefile
#              ^^    comment.line.number-sign.makefile

$(or \
     #$(or \
           #)#)#c
#          ^^^^    - comment.line.number-sign.makefile
#              ^^    comment.line.number-sign.makefile

$(or \
     #$(or \
           #)\
             #)#c
#            ^^    - comment.line.number-sign.makefile
#              ^^    comment.line.number-sign.makefile

# )})} #close


# ------------------ long lines: backtracking ----------------- #

# catastrophic backtracking -> Oniguruma retry limit aborts the match -> scopes missing
$(or $(or _____________________________________(_): =,\
#                                                     ^   punctuation.separator.continuation.makefile
#      ^^                                                 support.function.or.makefile
  ))
# )})} #close
