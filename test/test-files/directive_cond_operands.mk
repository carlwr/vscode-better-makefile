# SYNTAX TEST "source.makefile"


# ------------------------ parse tests ------------------------ #

# commas within quotes are literal:
ifeq "a,b" "a,b"
#     ^^^   ^^^     string.quoted.double.makefile
#      ^     ^    - punctuation.separator.delimiter.comma.condition.makefile
commaInQuotes := ok
endif
## /^commaInQuotes := ok/

# quotes within parens are literal:
ifneq ("c",c)
#      ^^^          string.unquoted.makefile
#      ^^^        - string.quoted.double.makefile
quotesInParens := ok
endif
## /^quotesInParens := ok/

# a \ escapes no quote:
ifeq 'd\' 'd\'
#      ^            string.quoted.single.makefile
#       ^           punctuation.definition.string.end.makefile
noQuoteEscapes := ok
endif
## /^noQuoteEscapes := ok/

# line cont. within parens:
ifeq (e,\
      e)
#      ^            punctuation.section.parens.end.condition.makefile
lineCont := ok
endif
## /^lineCont := ok/


# ------------------------ meta scopes ------------------------ #

ifeq (f,$(F)) # c
#    ^^^^^^^^       meta.scope.condition.parens.makefile
#             ^^^ - meta.scope.condition.parens.makefile
#             ^^^   comment.line.number-sign.makefile
endif

ifneq 'g' "$(G)"
#     ^^^ ^^^^^^    meta.scope.condition.quoted.makefile
#        ^        - meta.scope.condition.quoted.makefile
endif


# ------------------- expansions in operands ------------------ #

ifeq (h$(H),h)
#     ^     ^       string.unquoted.makefile
#    ^ ^^^^^ ^    - meta.string.makefile
#         ^         punctuation.definition.template-expression.end.makefile
#            ^      punctuation.section.parens.end.condition.makefile
endif

ifneq ($(if i,I,),)
#            ^ ^    punctuation.separator.delimiter.comma.function.makefile
#                ^  punctuation.separator.delimiter.comma.condition.makefile
endif

ifeq "j$(J)k" ''
#     ^    ^        meta.string.makefile
#      ^^^^       - meta.string.makefile
#        ^          variable.other.makefile
#              ^    punctuation.definition.string.end.makefile
endif


# -------------------------- comments ------------------------- #

ifeq "l\#m" 'L'# c
#      ^^           constant.character.escape.hash.makefile
#              ^^^  comment.line.number-sign.makefile
endif


# ---------------------------- else --------------------------- #

ifeq (n,N)
else ifneq (o,O)
#          ^        punctuation.section.parens.begin.condition.makefile
#            ^      punctuation.separator.delimiter.comma.condition.makefile
else ifeq 'p' "P"
#         ^^^       string.quoted.single.makefile
#             ^^^   string.quoted.double.makefile
endif


# ----------------- invalid syntax (keep last) ---------------- #

# make: a # within quotes starts a comment
ifeq "q#" "q#"
#      ^^^^^^^      comment.line.number-sign.makefile
endif

ifeq (r,R
rr = RR
#^^^^^^             meta.expression.assignment.makefile
endif

ifeq 's' 'S
ss = SS
#^^^^^^             meta.expression.assignment.makefile
endif
