# SYNTAX TEST "source.makefile"


# NOT escapes
# -----------

tt____\\_: p    ## /tt_*( )?[\\][\\]_: p/
#^^^^^^^^          meta.scope.targets.makefile
#          ^       meta.scope.prerequisites.makefile
#     ^          - constant.character.escape.backslash.makefile
#      ^         - meta.escaped-char.makefile


# implicit rules
# --------------

t0______%: p    ## /t0_*(     )?%: p/
#       ^          constant.other.placeholder.percent.makefile


t2____\\%: p    ## /t2_*( )?[\\]%: p/
#     ^            constant.character.escape.backslash.makefile
#      ^           meta.escaped-char.makefile
#       ^          constant.other.placeholder.percent.makefile

t4__\\\\%: p    ## /t4_*[\\][\\]%: p/
#   ^ ^            constant.character.escape.backslash.makefile
#    ^ ^           meta.escaped-char.makefile
#       ^          constant.other.placeholder.percent.makefile

u:p_\\\\%
#   ^ ^            constant.character.escape.backslash.makefile
#    ^ ^           meta.escaped-char.makefile
#       ^          constant.other.placeholder.percent.makefile


# files (the % are literal)
# -------------------------

t1_____\%: p    ## /t1_*(     )?%: p/
#      ^           constant.character.escape.backslash.makefile
#       ^          meta.escaped-char.makefile

t3___\\\%: p    ## /t3_*( )?[\\]%: p/
#    ^ ^           constant.character.escape.backslash.makefile
#     ^ ^          meta.escaped-char.makefile

v:p__\\\%
#    ^ ^           constant.character.escape.backslash.makefile
#     ^ ^          meta.escaped-char.makefile

t5_\\\\\%: p    ## /t5_*[\\][\\]%: p/
#  ^ ^ ^           constant.character.escape.backslash.makefile
#   ^ ^ ^          meta.escaped-char.makefile
