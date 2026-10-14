# SYNTAX TEST "source.makefile"

# Currently, punctuation used with conditional expressions for conditions are not supported. Tests below include example/placeholder names for non-existing scopes.

ifeq (aaaa,  AAAA)
#    ^           ^   punctuation.definition.conditional-operands.makefile
#         ^          punctuation.separator.conditional-operands.makefile

ifeq 'bbbb' 'BBBB'
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^ ^    ^   punctuation.definition.string.makefile
ifeq "cccc" "CCCC"
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^ ^    ^   punctuation.definition.string.makefile

ifeq "dddd" 'DDDD'
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^ ^    ^   punctuation.definition.string.makefile

ifeq 'eeee' "EEEE"
#     ^^^^   ^^^^    string.quoted.makefile
#    ^    ^ ^    ^   punctuation.definition.string.makefile

endif
endif
endif
endif
endif
#^^^^    keyword.control.endif.makefile

endif
#^^^^  - keyword.control.endif.makefile
