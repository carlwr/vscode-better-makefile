# SYNTAX TEST "source.makefile"


v := $(wildcard f)
#      ^^^^^^^^           support.function.wildcard.makefile

v := $(wildcard p*?[],%)
#               ^    ^^   string.unquoted.makefile
#                ^^^^     constant.other.placeholder.wildcard.makefile

t :  $(wildcard p*)
#               ^         string.unquoted.makefile
#                ^        constant.other.placeholder.wildcard.makefile

v=$(_$(wildcard p* p? )
#               ^  ^      string.unquoted.makefile
#                ^  ^     constant.other.placeholder.wildcard.makefile

v=$(_$(wildcard p* p?$$)
#               ^  ^      string.unquoted.makefile
#                ^  ^     constant.other.placeholder.wildcard.makefile
#                    ^^   constant.character.escape.dollar.makefile

v := $(wildcard #*)
#               ^         string.unquoted.makefile
#                ^        constant.other.placeholder.wildcard.makefile

v := $(wildcard \
                p*)
#               ^         string.unquoted.makefile
#                ^        constant.other.placeholder.wildcard.makefile


# ------------------------- negatives ------------------------- #

v := $(subst    p*)
#               ^^        string.unquoted.makefile
#                ^      - constant.other.placeholder.wildcard.makefile

v := $(flavor var*)
#             ^^^^        variable.other.makefile
#             ^^^^      - constant.other.placeholder.wildcard.makefile
