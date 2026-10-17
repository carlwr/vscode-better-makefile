# SYNTAX TEST "source.makefile"


# basic
# -----

var0 =str
#     ^^^           string.unquoted.makefile
#     ^^^           meta.string.makefile
var1 =str
#<-               - string.unquoted.makefile
#^^^^^            - string.unquoted.makefile
#<-               - meta.string.makefile
#^^^^^            - meta.string.makefile

var2 = s(t)r
#      ^^^^^        string.unquoted.makefile
var3 = s\trx
#      ^^^^^        string.unquoted.makefile
var4 = s\\tr
#      ^^^^^        string.unquoted.makefile
var5 = s\
          tr
#         ^^        string.unquoted.makefile


# with whitespaces
# ----------------

# per parse tests below, GNU make's behaviour:
# - any whitespaces after `=` are ignored
# - no trailing whitespaces are ignored

var6 = str
#      ^^^          string.unquoted.makefile
#     ^           - string.unquoted.makefile

var7 = s r
#      ^^^          string.unquoted.makefile
#     ^           - string.unquoted.makefile

var8 = s r  #c      ## /^var8 = s r  $/
#      ^^^^^        string.unquoted.makefile
#     ^     ^^    - string.unquoted.makefile

var9=  s r  #c      ## /^var9 = s r  $/
#      ^^^^^        string.unquoted.makefile
#    ^^     ^^    - string.unquoted.makefile

vr10 = s  r#        ## /^vr10 = s  r$/
#      ^^^^         string.unquoted.makefile
#     ^    ^^     - string.unquoted.makefile

# below: two trailing whitespaces, i e $'vr11 = str  \n':
vr11 = str  
#      ^^^^^        string.unquoted.makefile
#     ^           - string.unquoted.makefile
## /^vr11 = str  $/


# comments
# --------

vax1 =st#c
#     ^^            string.unquoted.makefile
#       ^^        - string.unquoted.makefile
vax2 =st\#c#c
#     ^^  ^         string.unquoted.makefile
#          ^^     - string.unquoted.makefile


# expansions
# ----------

vaz1 = s$(v)x
#      ^    ^         string.unquoted.makefile
#       ^^^^        - string.unquoted.makefile
vaz2 = s$cX
#      ^  ^           string.unquoted.makefile
#       ^^          - string.unquoted.makefile
vaz3 = s$(v$(a)r)x
#      ^         ^    string.unquoted.makefile
#       ^^^^^^^^^   - string.unquoted.makefile
vaz5 = x$(MAKE)y
#      ^       ^      string.unquoted.makefile
#       ^^^^^^^     - string.unquoted.makefile
#         ^^^^        variable.language.readwrite.special.makefile


# misc
# ----

# (deliberately under-specified, i.e. some chars have neither positive nor negative test; since either scoped or not scoped is considered acceptable)

vox1 = s tr x
#      ^ ^^ ^         string.unquoted.makefile
vox2 = s$$xy
#      ^  ^^          string.unquoted.makefile


# escapes
# -------

# for raw strings, such as RHS in assignment, a backslash can quote:
# - \#
# - \<nl> (line cont.)
# - itself for the two forms above

_esc0 = a\#b      ## /^\Q_esc0 = a#b/
#        ^^          constant.character.escape.hash.makefile
#       ^  ^         string.unquoted.makefile
_esc2 = a\\#b     ## /^_esc2 = a\\$/
#        ^^          constant.character.escape.backslash.makefile
#       ^            string.unquoted.makefile
#          ^^      - string.unquoted.makefile
_escX = a\
b                 ## /^\Q_escX = a b/
#<-                  string.unquoted.makefile
_escY = a\
#       ^            string.unquoted.makefile
