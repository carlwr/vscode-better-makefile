# SYNTAX TEST "source.makefile"


v = $(s____:f____%=r$(v)%)
#     ^^^^^               variable.other.makefile
#           ^^^^^  ^      string.unquoted.makefile
#          ^              punctuation.separator.substref.colon.makefile keyword.operator.substref.colon.makefile
#                 ^       punctuation.separator.substref.equal.makefile keyword.operator.substref.equal.makefile
#                ^      ^ variable.other.constant.substref.percent.makefile constant.other.placeholder.substref.percent.makefile
#            ^^^^^^^^^^^^ meta.substref.makefile
#     ^^^^^^^^^^^^^^^^^^^ meta.scope.expansion.makefile

v = $(s$(v):f____%=r____%)
#     ^  ^                variable.other.makefile
#          ^              punctuation.separator.substref.colon.makefile
#                 ^       punctuation.separator.substref.equal.makefile
#                ^      ^ constant.other.placeholder.substref.percent.makefile



v = $(s:f$(t:%u=%v)%=w%)
#      ^    ^             punctuation.separator.substref.colon.makefile
#              ^    ^     punctuation.separator.substref.equal.makefile
#            ^  ^  ^  ^   constant.other.placeholder.substref.percent.makefile
v = $(s:f${t:%u=%v}%=w%)
#      ^    ^             punctuation.separator.substref.colon.makefile
#              ^    ^     punctuation.separator.substref.equal.makefile
#            ^  ^  ^  ^   constant.other.placeholder.substref.percent.makefile
v = ${s:f$(t:%u=%v)%=w%}
#      ^    ^             punctuation.separator.substref.colon.makefile
#              ^    ^     punctuation.separator.substref.equal.makefile
#            ^  ^  ^  ^   constant.other.placeholder.substref.percent.makefile


v =              $(s$(v):f____%=r____%)
#                     ^   variable.other.makefile
v =        $(s____:f$(v)%=r____%)
#                     ^   variable.other.makefile
v = $(s____:f____%=r$(v)%)
#                     ^   variable.other.makefile

aa = $(A:find=repl)
#      ^                 variable.other.makefile


bb = $(B:find=repl)
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile

cc = $(C:%fnd=%rpl)
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile
#        ^    ^          constant.other.placeholder.substref.percent.makefile

dd = $(D:find=re$(V)pl)
#      ^          ^      variable.other.makefile

d2 = $(D$(v):f%=r%)
#      ^  ^              variable.other.makefile
#           ^            punctuation.separator.substref.colon.makefile
#              ^         punctuation.separator.substref.equal.makefile

gg = $(D:find=$$$(V)pl)
#      ^          ^      variable.other.makefile
#             ^^         constant.character.escape.dollar.makefile


ee = $(D:fi\
           n%=rep%)
#           ^    ^       constant.other.placeholder.substref.percent.makefile
#            ^           punctuation.separator.substref.equal.makefile
#          ^  ^^^        string.unquoted.makefile

ff = $(D:find=re$(V\
                   AR)pl)
#                     ^^ string.unquoted.makefile
#                  ^^    variable.other.makefile

# odd no. of \-s: line cont., the others are escaped \-s
hh = $(D:f\\\
#         ^^             constant.character.escape.backslash.makefile
#           ^            punctuation.separator.continuation.makefile
          %=r%)
#         ^  ^           constant.other.placeholder.substref.percent.makefile


# --------------------- in misc. contexts --------------------- #

e=$(e$(E:%fnd=%rpl))
#   ^  ^                 variable.other.makefile
#         ^^^  ^^^       string.unquoted.makefile
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile
#        ^    ^          constant.other.placeholder.substref.percent.makefile

t:$(e$(E:%fnd=%rpl))
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile
#        ^    ^          constant.other.placeholder.substref.percent.makefile

e=$(if ,$(E:%f=%r))
#          ^             punctuation.separator.substref.colon.makefile
#             ^          punctuation.separator.substref.equal.makefile
#           ^  ^         constant.other.placeholder.substref.percent.makefile

aa_= $(A:find=repl)
#    ^^ ^^^^^^^^^^^    - variable.other.makefile

dd_= $(D:find=re$(V)pl)
#    ^^ ^^^^^^^^^^ ^^  - variable.other.makefile

d3 = $(SHELL:%f=%r)
#      ^^^^^             variable.language.readwrite.special.makefile
#           ^            punctuation.separator.substref.colon.makefile
#              ^         punctuation.separator.substref.equal.makefile


# ----------------------- not in comment ---------------------- #

# cmt: $(CMT:%fnd=%rpl)
#           ^    ^     - punctuation.separator.substref.equal.makefile
#            ^    ^    - constant.other.placeholder.substref.percent.makefile
#            ^^^^^^^^^ - meta.substref.makefile
