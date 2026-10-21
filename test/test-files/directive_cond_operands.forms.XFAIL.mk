# SYNTAX TEST "source.makefile"

ifeq (aaaa,  AAAA)
#     ^^^^   ^^^^    string.unquoted.makefile
#    ^               punctuation.section.parens.begin.condition.makefile
#                ^   punctuation.section.parens.end.condition.makefile
#         ^          punctuation.separator.delimiter.comma.condition.makefile

ifeq 'bbbb' 'BBBB'
#    ^^^^^^ ^^^^^^   string.quoted.single.makefile
#    ^      ^        punctuation.definition.string.begin.makefile
#         ^      ^   punctuation.definition.string.end.makefile
ifeq "cccc" "CCCC"
#    ^^^^^^ ^^^^^^   string.quoted.double.makefile
#    ^      ^        punctuation.definition.string.begin.makefile
#         ^      ^   punctuation.definition.string.end.makefile

ifeq "dddd" 'DDDD'
#    ^^^^^^          string.quoted.double.makefile
#           ^^^^^^   string.quoted.single.makefile
#    ^      ^        punctuation.definition.string.begin.makefile
#         ^      ^   punctuation.definition.string.end.makefile

ifeq 'eeee' "EEEE"
#    ^^^^^^          string.quoted.single.makefile
#           ^^^^^^   string.quoted.double.makefile
#    ^      ^        punctuation.definition.string.begin.makefile
#         ^      ^   punctuation.definition.string.end.makefile

endif
endif
endif
endif
endif
#^^^^    keyword.control.endif.makefile

endif
#^^^^  - keyword.control.endif.makefile
