# SYNTAX TEST "source.makefile"



# preparatory tests
# -----------------

a0 = a __\
#        ^      constant.character.escape.line-continuation.makefile
#        ^      constant.character.escape.continuation.makefile
#        ^      punctuation.separator.continuation.makefile

a1 = a __\__
#        ^    - constant.character.escape.line-continuation.makefile
#        ^    - constant.character.escape.continuation.makefile
#        ^    - punctuation.separator.continuation.makefile

# \ + <nl> -> standard line cont.:
cont_std1 = c \
cont                ## /^cont_std1 = c cont  /


# main scope tests
# ----------------

# from now on, only test scope
#
#    punctuation.separator.continuation.makefile
#


# odd number of \-s: last is line-cont.:
a0 = a __\\\
#          ^      punctuation.separator.continuation.makefile
#        ^^     - punctuation.separator.continuation.makefile
a1 = a \\\\\
#          ^      punctuation.separator.continuation.makefile
#      ^^^^     - punctuation.separator.continuation.makefile

# even number of \-s: no line-cont.:
a2 = a ___\\
#         ^^    - punctuation.separator.continuation.makefile
a2 = a _\\\\
#       ^^^^    - punctuation.separator.continuation.makefile


# <nl> preceded by \
# -> NOT line cont.
# -> both \-s are literal \-characters, as usual
cont_esc2 = c \\
vpath                 ## /^\Qcont_esc2 = c \\/
                      ##    /cont_esc2 = c ..$/
cont_esc2_= c \\
#             ^^    - punctuation.separator.continuation.makefile

# even no. of \-s:
# -> NOT line cont.
#    keep all \-s
cont_esc4 = c \\\\
vpath                 ## /^\Qcont_esc4 = c \\\\/

cont_esc4_= c \\\\
#             ^^^^  - punctuation.separator.continuation.makefile


# odd no. of \-s:
# -> line cont.
#    keep half of \-s
cont_esc3 = c \\\
cont                  ## /^\Qcont_esc3 = c \ cont  /
  # keep 2/2=1

cont_esc3_= c \\\
#               ^     punctuation.separator.continuation.makefile

cont_esc5 = c \\\\\
cont                ## /^\Qcont_esc5 = c \\ cont  /
  # keep 4/2=2

cont_esc5_= c \\\\\
#                 ^   punctuation.separator.continuation.makefile

cont_esc7 = c \\\\\\\
cont

cont_esc7 = c \\\\\\\
#                   ^ punctuation.separator.continuation.makefile


# ----------------------- not line-cont. ---------------------- #

# a \, if not preceding a <nl>, is not special:
cont_var1 = a\b       ## /\Qcont_var1 = a\b/
#            ^      - punctuation.separator.continuation.makefile
cont_trg1_: a\b       ## /\Qcont_trg1_: a\b/
#            ^      - punctuation.separator.continuation.makefile
cont_var2 = \\b       ## /\Qcont_var2 = \\b/
#           ^^      - punctuation.separator.continuation.makefile


# --------------------------- ref's --------------------------- #

# misc.c:
#
#   /* Discard each backslash-newline combination from LINE.
#      Backslash-backslash-newline combinations become backslash-newlines.
#      This is done by copying the text at LINE into itself.  */
#   
#   void collapse_continuations (char *line) { .. }

