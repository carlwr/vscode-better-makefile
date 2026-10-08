# SYNTAX TEST "source.makefile"


# ------------------------ parse tests ------------------------ #

# (any parse tests must precede any actual load directives, since `make` will fail when encountering them and then stop creating the make database)

# "load" is a valid as target or variable name:
load: somePrereq0       ## /^load: somePrereq0$/
load := someValue       ## /^load := someValue/

# the colon must follow immediately after `load` - for the below, there will be no /load: somePrereq1/ in the make db (-> the `$` in the parse test above):
load : somePrereq1


# ----------------------- grammar tests ----------------------- #

load ./f.so
#<-              keyword.control.load.makefile
#^^^             keyword.control.load.makefile
#   ^^^^^^^    - keyword.control.load.makefile

load file # c
#^^^             keyword.control.load.makefile
#         ^^^    comment.line.number-sign.makefile

load f.so(f)
#^^^             keyword.control.load.makefile
#         ^      meta.scope.load-symbolname.makefile
#        ^ ^     punctuation.definition.parameters.load-symbolname.makefile

load dd$$_
#^^^             keyword.control.load.makefile
#      ^^        constant.character.escape.dollar.makefile

load e$(xp)
#^^^             keyword.control.load.makefile
#       ^^       variable.other.makefile
#    ^^^^^^    - meta.scope.load-symbolname.makefile

# odd no. of \-s: line cont., the others are escaped \-s
load f.so(s\\\
#            ^   punctuation.separator.continuation.makefile
  )
# ^              punctuation.section.load-symbolname.makefile


# _not_ load directives
# ---------------------

loadVar := value
#^^^^^^        - keyword.control.load.makefile

load: prereq
#^^^           - keyword.control.load.makefile

load := value
#^^^           - keyword.control.load.makefile

# load f
# ^^^^         - keyword.control.load.makefile
#^^^^^^^         comment.line.number-sign.makefile
