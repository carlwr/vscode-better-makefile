# SYNTAX TEST "source.makefile"


v := $(wildcard f)
#      ^^^^^^^^           support.function.wildcard.makefile
#               ^         meta.function-call.arguments.makefile

v := $(wildcard p*?[],%)
#               ^    ^^   string.unquoted.makefile
#                ^^^^     constant.other.placeholder.wildcard.makefile
#               ^^^^^^^   meta.function-call.arguments.makefile

v := $(wildcard ~)
#               ^         constant.other.placeholder.wildcard.makefile
#               ^         meta.function-call.arguments.makefile

v := $(wildcard ~word,%)
#                ^^^^^^   string.unquoted.makefile
#               ^         constant.other.placeholder.wildcard.makefile
#               ^^^^^^^   meta.function-call.arguments.makefile

v := $(wildcard ~/bin)
#                ^^^^     string.unquoted.makefile
#               ^         constant.other.placeholder.wildcard.makefile
#               ^^^^^     meta.function-call.arguments.makefile

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

v := $(wildcard word~)
#               ^^^^^     string.unquoted.makefile
#               ^^^^^     meta.function-call.arguments.makefile
#                   ^   - constant.other.placeholder.wildcard.makefile

v := $(wildcard \~abc)
#               ^^^^^     string.unquoted.makefile
#                ^      - constant.other.placeholder.wildcard.makefile

v := $(wildcard ~*)
#               ^       - constant.other.placeholder.wildcard.makefile

v := $(subst    p*)
#               ^^        string.unquoted.makefile
#                ^      - constant.other.placeholder.wildcard.makefile

v := $(flavor var*)
#             ^^^^        variable.other.makefile
#             ^^^^      - constant.other.placeholder.wildcard.makefile
