# SYNTAX TEST "source.makefile"



# -------------------------- mutable -------------------------- #

a =    $(VPATH)
#        ^^^^^      variable.language.readwrite.makefile
#        ^^^^^      meta.scope.expansion.makefile
#^^^^^^^^     ^   - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^     meta.expression.assignment.makefile

b = $(B$(SHELL))
#        ^^^^^      variable.language.readwrite.makefile
#^^^^^^^^     ^^  - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

c =  $@$(MAKE)
#        ^^^^       variable.language.readwrite.makefile
#^^^^^^^^    ^    - variable.language.readwrite.makefile
#^^^^^^^^^^^^^      meta.expression.assignment.makefile

v = $(GPATH)
#     ^^^^^         variable.language.readwrite.makefile


# ------------------------- negatives ------------------------- #

w = $( GPATH)
#     ^^^^^^      - variable.language.readwrite.makefile

x = $(_GPATH)
#     ^^^^^^      - variable.language.readwrite.makefile

y = $($GPATH)
#     ^^^^^^      - variable.language.readwrite.makefile

v = $(VPATH )
#     ^^^^^^  - variable.language.readwrite.makefile
#     ^^^^^^    variable.other.makefile


# ------------------------- immutable ------------------------- #

d =    $(CURDIR)
#        ^^^^^^     variable.language.constant.makefile
#^^^^^^^^      ^  - variable.language.constant.makefile
#^^^^^^^^^^^^^^^    meta.expression.assignment.makefile



# --------------------------- braces -------------------------- #

e =    ${VPATH}
#        ^^^^^      variable.language.readwrite.makefile
#^^^^^^^^     ^   - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^     meta.expression.assignment.makefile



# --------------------------- nested -------------------------- #

n0 = $(_$(SHELL))
#         ^^^^^      variable.language.readwrite.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

n1 =  $($(SHELL))
#         ^^^^^      variable.language.readwrite.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

n2 =  ${$(SHELL)}
#         ^^^^^      variable.language.readwrite.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile
