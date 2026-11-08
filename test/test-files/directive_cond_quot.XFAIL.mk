# SYNTAX TEST "source.makefile"

ifeq (aaaa,  AAAA)
#    ^           ^			punctuation.definition.conditional-operands.makefile
#         ^          punctuation.separator.conditional-operands.makefile

ifeq 'bbbb' 'BBBB'
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^	^    ^			punctuation.definition.string.shell
ifeq "cccc" "CCCC"
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^	^    ^			punctuation.definition.string.shell

ifeq "dddd" 'DDDD'
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^	^    ^			punctuation.definition.string.shell

ifeq 'eeee' "EEEE"
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^	^    ^			punctuation.definition.string.shell

endif
endif
endif
endif
endif
#^^^^    keyword.control.endif.makefile

endif
#^^^^  - keyword.control.endif.makefile
