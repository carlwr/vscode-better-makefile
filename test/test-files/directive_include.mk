# SYNTAX TEST "source.makefile"


include foo
#^^^^^^             keyword.control.include.makefile

   include a b
#  ^^^^^^^          keyword.control.include.makefile
#          ^ ^      string.unquoted.path.makefile
#           ^     - string.unquoted.path.makefile

-include opt
#^^^^^^^            keyword.control.include.makefile
#<-                 keyword.control.include.makefile
#        ^^^        string.unquoted.path.makefile

sinclude also
#^^^^^^^            keyword.control.include.makefile
#<-                 keyword.control.include.makefile
#        ^^^^       string.unquoted.path.makefile

sinclude al:o
#^^^^^^^            keyword.control.include.makefile
#<-                 keyword.control.include.makefile
#        ^^^^       string.unquoted.path.makefile


# paths
# -----

include foo
#^^^^^^^          - string.unquoted.path.makefile

include $(d)/f.mk *.mk
#       ^^^^      - string.unquoted.path.makefile
#           ^^^^^   string.unquoted.path.makefile
#                 ^^^^  string.unquoted.path.makefile

include %.mk
#       ^         - string.unquoted.path.makefile
#       ^           constant.other.placeholder.percent.makefile
#        ^^^        string.unquoted.path.makefile

include a # c
#       ^           string.unquoted.path.makefile
#         ^^^     - string.unquoted.path.makefile

include a\#b
#       ^  ^        string.unquoted.path.makefile
#        ^^       - string.unquoted.path.makefile
