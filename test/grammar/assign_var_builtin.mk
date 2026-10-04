# SYNTAX TEST "source.makefile"


# ------------------------- assignment ------------------------ #

SHELL := v
#<-                variable.language.readwrite.makefile
#^^^^              variable.language.readwrite.makefile
#^^^^              variable.other.assignment.makefile
#^^^^              variable.other.constant.makefile

CURDIR = v
#^^^^^             variable.language.constant.makefile
#^^^^^             constant.language.makefile

.RECIPEPREFIX := v
#^^^^^^^^^^^^      variable.language.readwrite.makefile

export SHELL := v
#      ^^^^^       variable.language.readwrite.makefile


# --------------------------- define -------------------------- #

define MAKEFLAGS =
#      ^^^^^^^^^   variable.language.readwrite.makefile
#      ^^^^^^^^^   variable.other.assignment.makefile
endef

define SHELL
#      ^^^^^       variable.language.readwrite.makefile
endef

define SHELL:
#      ^^^^^     - variable.language.readwrite.makefile
endef
## /^(define )?SHELL:(?(1)$|( =))/


# ------------------- expansion in the name ------------------- #

pre$(MAKEFLAGS) := v
#    ^^^^^^^^^     variable.language.readwrite.makefile


# ------------------------- negatives ------------------------- #

MYSHELL   := v
#^^^^^^          - variable.language.readwrite.makefile

SHELL_x   := v
#^^^^^^          - variable.language.readwrite.makefile

$(p)SHELL := v
#   ^^^^^        - variable.language.readwrite.makefile

SHELL$(p) := v
#^^^^            - variable.language.readwrite.makefile

$$SHELL := v
# ^^^^^          - variable.language.readwrite.makefile
