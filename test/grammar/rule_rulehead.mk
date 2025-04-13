# SYNTAX TEST "source.makefile"

# avoid make errors, so the make database can be inspected:
$$ := dollar


# basics
# ------

__target       : p
#^^^^^^^^^^^^^^^^^ meta.scope.rulehead.makefile
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
#^^^^^^^           entity.name.function.target.makefile
#       ^^^^^^^  - entity.name.function.target.makefile
#              ^   punctuation.separator.key-value.rulehead.makefile
#                ^ meta.scope.prerequisites.makefile
__target  ____B: p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
#^^^^^^^  ^^^^^    entity.name.function.target.makefile
#              ^   punctuation.separator.key-value.rulehead.makefile
#                ^ meta.scope.prerequisites.makefile
  target  ____B: p
# ^^^^^^^^^^^^^    meta.scope.targets.makefile


# expansions
# ----------

$(var)         : p
# ^^^              variable.other.makefile
#<-                punctuation.definition.variable.makefile
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
$v:
#^                 meta.scope.targets.makefile
#<-                meta.scope.targets.makefile
#^                 variable.other.makefile
#<-                punctuation.definition.variable.makefile
__ta$(v)  $(v)B: p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
#^^^          ^    entity.name.function.target.makefile
#     ^     ^      variable.other.makefile
$(v)rget  $(v)B: p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
# ^         ^      variable.other.makefile
$(v)$(w)  $(v)B: p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
# ^   ^     ^      variable.other.makefile

$(eval a:=b)t  : p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
# ^^^^^^^^^        meta.scope.function-call.makefile
$(or ,)t  ____B: p
#^^^^^^^^^^^^^^    meta.scope.targets.makefile
#         ^^^^^    entity.name.function.target.makefile
# ^^^^             meta.scope.function-call.makefile
tX: $(v) $(v)B
#  ^^^^^^^^^^^     meta.scope.prerequisites.makefile
#     ^    ^       variable.other.makefile
tY:  $c    $cB
#  ^^^^^^^^^^^^    meta.scope.prerequisites.makefile
#     ^     ^      variable.other.makefile
tZ: %$c    $c%
#  ^^^^^^^^^^^     meta.scope.prerequisites.makefile
#     ^     ^      variable.other.makefile
$(words str):
#           ^    - entity.name.function.target.makefile
#^^^^^^^^^^^       meta.scope.targets.makefile
#<-                meta.scope.targets.makefile
# ^^^^^            support.function.words.makefile
#<-                punctuation.definition.variable.makefile


# substref
# --------

$(t:a=A): prereq
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^^^   meta.scope.prerequisites.makefile
#   ^^^            meta.substref.makefile
${t:a=A}: prereq
#^^^^^^^           meta.scope.targets.makefile
#   ^^^            meta.substref.makefile
targD   : p$(p:a=A)
#^^^^^^^           meta.scope.targets.makefile
#        ^^^^^^^^^ meta.scope.prerequisites.makefile
#              ^^^ meta.substref.makefile


# various chars, escapes in targets
# ---------------------------------

__a\:trg: PRE
#^^^^^^^           meta.scope.targets.makefile
#         ^^^      meta.scope.prerequisites.makefile
_\\\:trg: PRE
#^^^^^^^           meta.scope.targets.makefile
#         ^^^      meta.scope.prerequisites.makefile
__\\:     PRE
#^^^               meta.scope.targets.makefile
#         ^^^      meta.scope.prerequisites.makefile
\\\\:     PRE
#^^^               meta.scope.targets.makefile
#         ^^^      meta.scope.prerequisites.makefile


targ_&_t: preA
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
tar2 & t: pre2
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
ta3 \: t: pre3
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
ta3b\:_t: pre3
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
t \\\: t: preB
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
ta4   \\: pre4
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
ta5\_   : pre5
#^^^^^^^           meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile

# first : escaped, second the separator:
ta6___\:: pre5
#      ^         - punctuation.separator.key-value.rulehead.makefile
#       ^          punctuation.separator.key-value.rulehead.makefile

# first : escaped, second the separator:
ta6___\:: pre5
#      ^         - punctuation.separator.key-value.rulehead.makefile
#       ^          punctuation.separator.key-value.rulehead.makefile

# interestingly, `make` does not consider this & escaped - this is a multi-target rule:
t7a t7\&: pre5;
#      ^^          punctuation.separator.key-value.rulehead.makefile

t$$g__  : p$$q
#^^^^^             meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile

# raw (, ) in targets/prereqs:

br0(__  : p0__     ## /^\Qbr0(__: p0/
#^^^^^             meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
br1)__  : p1__     ## /^\Qbr1)__: p1/
#^^^^^             meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile
br2___  : p2(_     ## /^\Qbr2___: p2(_/
#^^^^^             meta.scope.targets.makefile
#         ^^^^     meta.scope.prerequisites.makefile


# not misinterpreted
# ------------------

targ: pre # a=b
#^^^^^^^^          meta.scope.rulehead.makefile
#     ^^^          meta.scope.prerequisites.makefile

targ: pre$(a#b)req
#^^^^^^^^          meta.scope.rulehead.makefile
#     ^^^^^^^^^^^^ meta.scope.prerequisites.makefile


# negatives
# ---------

string # n : t
#^^^^^^^^^^^^^   - meta.scope.rulehead.makefile
str\ng
#^^^^^           - meta.scope.rulehead.makefile
:tring
#^^^^^           - meta.scope.rulehead.makefile
str\:_
#^^^^^           - meta.scope.rulehead.makefile
_\\\:_
#^^^^^           - meta.scope.rulehead.makefile

$(v:r)______str
#^^^^^^^^^^^^^^  - meta.scope.rulehead.makefile
$(v:r)$(v:r)str
#^^^^^^^^^^^^^^  - meta.scope.rulehead.makefile
$(v:r)${v:r}str
#^^^^^^^^^^^^^^  - meta.scope.rulehead.makefile


# missed rules
# ------------

# current grammar handles only one level of nesting in the target list and will miss this rule:
$(b$(w)c)_targ: pre







