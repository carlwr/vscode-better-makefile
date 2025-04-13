# SYNTAX TEST "source.makefile"

# strings should have the two scopes:
# * string.unquoted
# * meta.string
#
# ref.: https://www.sublimetext.com/docs/scope_naming.html#string


var = string
#     ^^^^^^          string.unquoted
#     ^^^^^^          meta.string
#^^^^^              - string.unquoted
#^^^^^              - meta.string

var = s\#str
#     ^^^^^^          string.unquoted
#     ^^^^^^          meta.string


var = string#cmt
#           ^^^^    - string.unquoted
#           ^^^^    - meta.string
#           ^^^^    - string.unquoted
#           ^^^^    - meta.string

var = str\
         ing
#        ^^^          string.unquoted
#        ^^^          meta.string


var = __$(v)_____
var = __$(or ,)__
var = __$c_______


# cmt -> NOT str
#^^^^^^^^^^^^^^^    - string.unquoted
#^^^^^^^^^^^^^^^    - meta.string
#<-                 - string.unquoted
#<-                 - meta.string
