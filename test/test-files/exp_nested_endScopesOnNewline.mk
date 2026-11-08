# SYNTAX TEST "source.makefile"

# scopes for nested expansions should not be left open over non-linecont newlines
# since:
# 1. that is how GNU make behaves
# 2. scoping errors should not leave wrong scopes open over following lines
#    (most important of the two)

${or
# cmt
#^^^^          comment.line.number-sign.makefile
}
# )})} #close

$(or
# cmt
#^^^^          comment.line.number-sign.makefile
)
# )})} #close

$(or ()
# cmt
#^^^^          comment.line.number-sign.makefile
)
# )})} #close

$(or {}
# cmt
#^^^^          comment.line.number-sign.makefile
)
# )})} #close

${or (}
# cmt
#^^^^          comment.line.number-sign.makefile
# )})} #close

$(or {)
# cmt
#^^^^          comment.line.number-sign.makefile
# )})} #close

a0 = ${or (}
# cmt
#^^^^          comment.line.number-sign.makefile
# )})} #close

a0 = $(or $(or {)
# cmt
#^^^^          comment.line.number-sign.makefile
)
# )})} #close

a0 = ${or ${or (}
# cmt
#^^^^          comment.line.number-sign.makefile
}
# )})} #close


# with line cont.
# ---------------

$(or (\
      )
# cmt
#^^^^          comment.line.number-sign.makefile
)
# )})} #close

${or (\
      }
# cmt
#^^^^          comment.line.number-sign.makefile

# )})} #close
