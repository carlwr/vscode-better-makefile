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


# escapes
# -------

a0_ = aa \ b
#     ^^^^^^  string.unquoted
#     ^^^^^^  meta.string
a1_ = a \c b
#     ^^^^^^  string.unquoted
#     ^^^^^^  meta.string
a2_ = a \\ b
#     ^^^^^^  string.unquoted
#     ^^^^^^  meta.string
