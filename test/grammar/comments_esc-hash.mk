# SYNTAX TEST "source.makefile"

v = \\\\\\#c

# regexes below: use [\\] for matching a backslash character since more readable


# ----------------------- quoted `#`: \# ---------------------- #

vaq0 = a_\#b    ## /vaq0 = a_#b/
#        ^         constant.character.escape.backslash.makefile
#         ^        meta.escaped-char.makefile
#         ^      - comment.line.number-sign.makefile
tgq0: _a_\#b    ## /tgq0: _a_#b/
#        ^         constant.character.escape.backslash.makefile
#         ^        meta.escaped-char.makefile
#         ^      - comment.line.number-sign.makefile

vaq1__ = \#b    ## /vaq1__ = #b/
#        ^         constant.character.escape.backslash.makefile
#         ^        meta.escaped-char.makefile
#         ^      - comment.line.number-sign.makefile
tgq0___: \#b    ## /tgq0___: #b/
#        ^         constant.character.escape.backslash.makefile
#         ^        meta.escaped-char.makefile
#         ^      - comment.line.number-sign.makefile


# ------ quoted `\`: \\ (only if it avoids quoting a `#`) ----- #

# \\# == quoted \ + #-comment:
# (note: here, \\ is replaced by \; backslash 1 quotes backslash 2)

var0 = a\\#c    ## /var0 = a[\\]$/
#       ^          constant.character.escape.backslash.makefile
#        ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile
tgt0: _a\\#c    ## /tgt0: _a[\\]$/
#       ^          constant.character.escape.backslash.makefile
#        ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile

var1_ = \\#c    ## /var1_ = [\\]$/
#       ^          constant.character.escape.backslash.makefile
#        ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile
tgt1__: \\#c    ## /tgt1__: [\\]$/
#       ^          constant.character.escape.backslash.makefile
#        ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile

var2= \\\\#c    ## /var2 = [\\][\\]$/
#     ^ ^          constant.character.escape.backslash.makefile
#      ^ ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile
tgt2: \\\\#c    ## /tgt2: [\\][\\]$/
#     ^ ^          constant.character.escape.backslash.makefile
#      ^ ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile

va3=\\\\\\#c    ## /va3 = [\\][\\][\\]$/
#   ^ ^ ^          constant.character.escape.backslash.makefile
#    ^ ^ ^         meta.escaped-char.makefile
#         ^^       comment.line.number-sign.makefile


# \\<other_char> == \\<other_char>
#   - a backslash quotes another backslash only if that avoids the latter quiting a `#`
#   - -> the \-s are not special here:

van2 = a\\b     ## /van2 = a[\\][\\]b/
#       ^^       - constant.character.escape.backslash.makefile
#       ^^       - meta.escaped-char.makefile
tgn2: _a\\b     ## /tgn2: _a[\\][\\]b/
#       ^^       - constant.character.escape.backslash.makefile
#       ^^       - meta.escaped-char.makefile

van3 = a\\\b    ## /van3 = a[\\][\\][\\]b/
#       ^^^      - constant.character.escape.backslash.makefile
#       ^^^      - meta.escaped-char.makefile


# --------------- quoted `\` and `#` in sequence -------------- #

vax1= \\\#b     ## /vax1 = [\\]#b/
#     ^ ^          constant.character.escape.backslash.makefile
#      ^ ^         meta.escaped-char.makefile
#        ^^      - comment.line.number-sign.makefile

vax2= \\\\\#b   ## /vax2 = [\\][\\]#b/
#     ^ ^ ^        constant.character.escape.backslash.makefile
#      ^ ^ ^       meta.escaped-char.makefile
#          ^^    - comment.line.number-sign.makefile

vax3= \\\\\\\#b ## /vax3 = [\\][\\][\\]#b/
#     ^ ^ ^ ^      constant.character.escape.backslash.makefile
#      ^ ^ ^ ^     meta.escaped-char.makefile
#            ^^  - comment.line.number-sign.makefile


# ---------------------------- misc --------------------------- #

vay0 = \\\#b#c
#      ^ ^         constant.character.escape.backslash.makefile
#       ^ ^        meta.escaped-char.makefile
#         ^^     - comment.line.number-sign.makefile
#           ^^     comment.line.number-sign.makefile

vay2 = \#b\#b\\#c
#      ^  ^  ^     constant.character.escape.backslash.makefile
#       ^  ^  ^    meta.escaped-char.makefile
#              ^^  comment.line.number-sign.makefile

vay3 = \
       \#b\#b\\#c
#      ^  ^  ^     constant.character.escape.backslash.makefile
#       ^  ^  ^    meta.escaped-char.makefile
#              ^^  comment.line.number-sign.makefile


t: p0 \#\
   p1
#  ^^      meta.scope.prerequisites.makefile

t: p0 \\#\
   p1
#  ^^      comment.line.number-sign.makefile
