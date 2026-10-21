# SYNTAX TEST "source.makefile"


v := $(patsubst pat,repl,t)
#      ^^^^^^^^           support.function.patsubst.makefile

v := $(patsubst p% ,r%,t)
#               ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile

t :  $(patsubst p% ,r%,t)
#               ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile

v=$(_$(patsubst p% ,r%,t))
#               ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile

v := $(patsubst #% ,r%,t)
#               ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile

v := $(patsubst \
                p% ,r%,t)
#               ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile


v := $(filter o p% ,r%)
#             ^ ^   ^     string.unquoted.makefile
#                ^   ^    constant.other.placeholder.percent.makefile
#                  ^      punctuation.separator.delimiter.comma.function.makefile


# ------------------------- negatives ------------------------- #

v := $(patsubst p* ,r*,t)
#               ^^  ^^    string.unquoted.makefile
#                ^   ^  - constant.other.placeholder.percent.makefile

v := $(subst    p% ,r%,t)
#               ^^  ^^    string.unquoted.makefile
#                ^   ^  - constant.other.placeholder.percent.makefile
#                  ^  ^   punctuation.separator.delimiter.comma.function.makefile
