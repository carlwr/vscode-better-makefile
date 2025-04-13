# SYNTAX TEST "source.makefile"

var0 =str
#     ^^^     string.unquoted
#     ^^^     meta.string

var1 =str
#<-         - string.unquoted
#^^^^^      - string.unquoted
#<-         - meta.string
#^^^^^      - meta.string

var2 =st#c
#     ^^      string.unquoted
#       ^^  - string.unquoted
#     ^^      meta.string
#       ^^  - meta.string
