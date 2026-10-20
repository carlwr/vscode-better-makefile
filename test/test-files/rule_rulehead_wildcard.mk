# SYNTAX TEST "source.makefile"


*: p
#<-        meta.scope.target.makefile
#<-        variable.language.special.wildcard.makefile variable.other.constant.wildcard.makefile constant.other.placeholder.wildcard.makefile
#  ^       meta.scope.prerequisites.makefile


targ: *
#^^^       meta.scope.target.makefile
#     ^    meta.scope.prerequisites.makefile
#     ^    variable.language.special.wildcard.makefile
#     ^    variable.other.constant.wildcard.makefile
#     ^    constant.other.placeholder.wildcard.makefile

_?_*: [ _]
#^ ^  ^  ^ variable.language.special.wildcard.makefile
#^^^       meta.scope.target.makefile
#     ^^^^ meta.scope.prerequisites.makefile

sbf/f ~rms/f: g
#     ^       variable.language.special.wildcard.makefile
#^^^^^^^^^^^  meta.scope.target.makefile

~rms/f: g
#<-        variable.language.special.wildcard.makefile
#^^^^^     meta.scope.target.makefile

word~: g
#   ^    - variable.language.special.wildcard.makefile
#^^^^      meta.scope.target.makefile



# escapes
# -------

\*: p
#<-        constant.character.escape.wildcard.makefile
#<-      - variable.language.special.wildcard.makefile
#^       - variable.language.special.wildcard.makefile
#^         meta.scope.target.makefile
#   ^      meta.scope.prerequisites.makefile

t_\\*: p
# ^^       constant.character.escape.backslash.makefile
#   ^      variable.language.special.wildcard.makefile
#^^^^      meta.scope.target.makefile
#      ^   meta.scope.prerequisites.makefile

targ:\*
#    ^^    constant.character.escape.wildcard.makefile
#     ^  - variable.language.special.wildcard.makefile
#^^^       meta.scope.target.makefile
#    ^^    meta.scope.prerequisites.makefile



# negatives
# ---------

v  =  *
#     ^  - variable.language.special.wildcard.makefile

#cmt: *
#     ^  - variable.language.special.wildcard.makefile
