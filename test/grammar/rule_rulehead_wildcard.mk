# SYNTAX TEST "source.makefile"


*: p
#<-        variable.language.special.wildcard.makefile
#<-        meta.scope.target.makefile
#  ^       meta.scope.prerequisites.makefile


targ: *
#     ^    variable.language.special.wildcard.makefile
#^^^       meta.scope.target.makefile
#     ^    meta.scope.prerequisites.makefile


_?_*: [ _]
#^ ^  ^  ^ variable.language.special.wildcard.makefile
#^^^       meta.scope.target.makefile
#     ^^^^ meta.scope.prerequisites.makefile



# escapes
# -------

\*: p
#<-      - variable.language.special.wildcard.makefile
#^       - variable.language.special.wildcard.makefile
#^         meta.scope.target.makefile
#   ^      meta.scope.prerequisites.makefile

t_\\*: p
# ^        constant.character.escape.backslash.makefile
#  ^       meta.escaped-char.makefile
#   ^      variable.language.special.wildcard.makefile
#^^^^      meta.scope.target.makefile
#      ^   meta.scope.prerequisites.makefile

targ:\*
#    ^     constant.character.escape.backslash.makefile
#     ^  - variable.language.special.wildcard.makefile
#     ^    meta.escaped-char.makefile
#^^^       meta.scope.target.makefile
#    ^^    meta.scope.prerequisites.makefile



# negatives
# ---------

v  =  *
#     ^  - variable.language.special.wildcard.makefile

#cmt: *
#     ^  - variable.language.special.wildcard.makefile
