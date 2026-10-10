# SYNTAX TEST "source.makefile"


# ------------------------- assignment ------------------------ #

SHELL := v
#<-                variable.language.readwrite.special.makefile
#^^^^              variable.language.readwrite.special.makefile
#^^^^              variable.other.assignment.makefile

CURDIR = v
#^^^^^             variable.language.constant.special.makefile

.RECIPEPREFIX := v
#^^^^^^^^^^^^      variable.language.readwrite.special.makefile

export SHELL := v
#      ^^^^^       variable.language.readwrite.special.makefile


# --------------------------- define -------------------------- #

define MAKEFLAGS =
#      ^^^^^^^^^   variable.language.readwrite.special.makefile
#      ^^^^^^^^^   variable.other.assignment.makefile
endef

define SHELL
#      ^^^^^       variable.language.readwrite.special.makefile
endef

define SHELL:
#      ^^^^^     - variable.language.readwrite.special.makefile
endef
## /^(define )?SHELL:(?(1)$|( =))/


# ------------------- expansion in the name ------------------- #

pre$(MAKEFLAGS) := v
#    ^^^^^^^^^     variable.language.readwrite.special.makefile


# ------------------------- negatives ------------------------- #

MYSHELL   := v
#^^^^^^          - variable.language.readwrite.special.makefile

SHELL_x   := v
#^^^^^^          - variable.language.readwrite.special.makefile

$(p)SHELL := v
#   ^^^^^        - variable.language.readwrite.special.makefile

SHELL$(p) := v
#^^^^            - variable.language.readwrite.special.makefile

$$SHELL := v
# ^^^^^          - variable.language.readwrite.special.makefile
