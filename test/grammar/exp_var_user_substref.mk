# SYNTAX TEST "source.makefile"


v = $(s____:f____%=r$(v)%)
#          ^              punctuation.separator.substref.colon.makefile
#                 ^       punctuation.separator.substref.equal.makefile
#                ^      ^ constant.other.placeholder.substref.percent.makefile
v = $(s$(v):f____%=r____%)
#          ^              punctuation.separator.substref.colon.makefile
#                 ^       punctuation.separator.substref.equal.makefile
#                ^      ^ constant.other.placeholder.substref.percent.makefile



v = $(s:f$(t:%u=%v)%=w%)
#   ^^   ^^       ^    ^  punctuation.definition.variable.makefile
#      ^    ^             punctuation.separator.substref.colon.makefile
#              ^    ^     punctuation.separator.substref.equal.makefile
#            ^  ^  ^  ^   constant.other.placeholder.substref.percent.makefile
v = $(s:f${t:%u=%v}%=w%)
#   ^^   ^^       ^    ^  punctuation.definition.variable.makefile
#      ^    ^             punctuation.separator.substref.colon.makefile
#              ^    ^     punctuation.separator.substref.equal.makefile
#            ^  ^  ^  ^   constant.other.placeholder.substref.percent.makefile
v = ${s:f$(t:%u=%v)%=w%}
#   ^^   ^^       ^    ^  punctuation.definition.variable.makefile
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
#    ^^           ^      punctuation.definition.variable.makefile


bb = $(B:find=repl)
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile

cc = $(C:%fnd=%rpl)
#       ^                punctuation.separator.substref.colon.makefile
#            ^           punctuation.separator.substref.equal.makefile
#        ^    ^          constant.other.placeholder.substref.percent.makefile

dd = $(D:find=re$(V)pl)
#      ^          ^      variable.other.makefile
#    ^^         ^^ ^  ^  punctuation.definition.variable.makefile

d2 = $(D$(v):f%=r%)
#      ^  ^              variable.other.makefile
#    ^^ ^^ ^      ^      punctuation.definition.variable.makefile
#           ^            punctuation.separator.substref.colon.makefile
#              ^         punctuation.separator.substref.equal.makefile

gg = $(D:find=$$$(V)pl)
#      ^          ^      variable.other.makefile
#    ^^         ^^ ^  ^  punctuation.definition.variable.makefile
#             ^^         constant.character.escape.dollar.makefile


# TODO:
ee = $(D:fi\
           n%=rep%)
# cmt

ff = $(D:find=re$(V\
                   AR)pl)
# cmt

# --------------------- in misc. contexts --------------------- #

e=$(e$(E:%fnd=%rpl))
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
#      ^^^^^             variable.language.readwrite.makefile
#           ^            punctuation.separator.substref.colon.makefile
#              ^         punctuation.separator.substref.equal.makefile


# ----------------------- not in comment ---------------------- #

# cmt: $(CMT:%fnd=%rpl)
#           ^    ^     - punctuation.separator.substref.equal.makefile
#            ^    ^    - constant.other.placeholder.substref.percent.makefile
#            ^^^^^^^^^ - meta.substref.makefile
