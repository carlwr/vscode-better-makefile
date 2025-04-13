# SYNTAX TEST "source.makefile"

vpath
#^^^^       keyword.control.vpath.makefile

vpath %.c p
#^^^^       keyword.control.vpath.makefile
#     ^     constant.other.placeholder.percent.makefile

vpath % p:q
#^^^^       keyword.control.vpath.makefile
#     ^     constant.other.placeholder.percent.makefile

vpath \% p
#     ^     constant.character.escape.backslash.makefile
#      ^    meta.escaped-char.makefile
#      ^  - constant.other.placeholder.percent.makefile
vpath \\% p
#     ^     constant.character.escape.backslash.makefile
#      ^    meta.escaped-char.makefile
#       ^   constant.other.placeholder.percent.makefile

vpath % path1:path2
#            ^       punctuation.separator.paths.vpath.makefile


# GNU make manual:
#
#    '%' characters in a 'vpath' directive's pattern can be quoted with
#    preceding backslashes ('\').  Backslashes that would otherwise quote '%'
#    characters can be quoted with more backslashes.  Backslashes that quote
#    '%' characters or other backslashes are removed from the pattern before
#    it is compared to file names.  Backslashes that are not in danger of
#    quoting '%' characters go unmolested.
