# SYNTAX TEST "source.makefile"



# -------------------------- mutable -------------------------- #

a =    $(VPATH)
#        ^^^^^      variable.language.readwrite.special.makefile
#        ^^^^^      meta.scope.expansion.makefile
#^^^^^^^^     ^   - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^     meta.expression.assignment.makefile

b = $(B$(SHELL))
#        ^^^^^      variable.language.readwrite.special.makefile
#^^^^^^^^     ^^  - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

c =  $@$(MAKE)
#        ^^^^       variable.language.readwrite.special.makefile
#^^^^^^^^    ^    - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^      meta.expression.assignment.makefile

v = $(GPATH)
#     ^^^^^         variable.language.readwrite.special.makefile


# ------------------------- negatives ------------------------- #

w = $( GPATH)
#     ^^^^^^      - variable.language.readwrite.special.makefile

x = $(_GPATH)
#     ^^^^^^      - variable.language.readwrite.special.makefile

y = $($GPATH)
#     ^^^^^^      - variable.language.readwrite.special.makefile

v = $(VPATH )
#     ^^^^^^      - variable.language.readwrite.special.makefile
#     ^^^^^^        variable.other.makefile

z = $(a$(b)SHELL)
#          ^^^^^  - variable.language.readwrite.special.makefile

t = $(foo \
SHELL)
#^^^^             - variable.language.readwrite.special.makefile


# ------------------------- immutable ------------------------- #

d =    $(CURDIR)
#        ^^^^^^     variable.language.constant.special.makefile
#^^^^^^^^      ^  - variable.language.constant.special.makefile
#^^^^^^^^^^^^^^^    meta.expression.assignment.makefile



# --------------------------- braces -------------------------- #

e =    ${VPATH}
#        ^^^^^      variable.language.readwrite.special.makefile
#^^^^^^^^     ^   - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^     meta.expression.assignment.makefile



# --------------------------- nested -------------------------- #

n0 = $(_$(SHELL))
#         ^^^^^      variable.language.readwrite.special.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

n1 =  $($(SHELL))
#         ^^^^^      variable.language.readwrite.special.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile

n2 =  ${$(SHELL)}
#         ^^^^^      variable.language.readwrite.special.makefile
#^^^^^^^^^     ^^  - variable.language.readwrite.special.makefile
#^^^^^^^^^^^^^^^^    meta.expression.assignment.makefile
