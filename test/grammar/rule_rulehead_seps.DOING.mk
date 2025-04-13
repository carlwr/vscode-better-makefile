# SYNTAX TEST "source.makefile"


# single-colon
# ------------

targA_:
#     ^        punctuation.separator.key-value.rulehead.makefile

targB_ :
#      ^       punctuation.separator.key-value.rulehead.makefile

targC*:
#    ^       - punctuation.separator.key-value.rulehead.makefile
#     ^        punctuation.separator.key-value.rulehead.makefile

targD%:
#    ^       - punctuation.separator.key-value.rulehead.makefile
#     ^        punctuation.separator.key-value.rulehead.makefile

targE_:dep
#     ^        punctuation.separator.key-value.rulehead.makefile
#^^^^^ ^^^   - punctuation.separator.key-value.rulehead.makefile

targF_ : dep
#      ^       punctuation.separator.key-value.rulehead.makefile



# DOING
# -----



# double-colon :: (only static rules)

dc1:: dc1a
#  ^^       punctuation.separator.key-value.rulehead.makefile

# terminal rules :: (only pattern rules)
%:: s.%
#^^       punctuation.separator.key-value.rulehead.makefile

# grouped target &:, &::

gt1 &: gt1a; rec
#   ^^       punctuation.separator.key-value.rulehead.makefile

#gt2X_gt2Y := val


gt_dc1 &:: gt_dc1a; rec
#      ^^^      punctuation.separator.key-value.rulehead.makefile


# the '&' char in various contexts
# --------------------------------


# with '&:=', := is the assignment operator:

var-and_&:= val  ## /^var-and_& := val/
#^^^^^^^^        variable.other.assignment.makefile
#        ^^      keyword.operator.assignment.makefile
#       ^^^    - punctuation.separator.key-value.rulehead.makefile

# & chars in targets are not special:

# GNU make interpretation:
and1__&__and-1: and_pre  ## /(?x)^and1__&__and-1:\ and_pre/
and2__&  and-2: and_pre  ## /(?x)^and2__&       :\ and_pre/
and3  &__and-3: and_pre  ## /(?x)^      &__and-3:\ and_pre/
and4  &  and-4: and_pre  ## /(?x)^      &       :\ and_pre/

# test scopes:
and1__&__and-1: and_pre
#^^^^^^^^^^^^^           meta.scope.targets.makefile
#             ^          punctuation.separator.key-value.rulehead.makefile
and4  &  and-4: and_pre
#^^^^^^^^^^^^^           meta.scope.targets.makefile
#             ^          punctuation.separator.key-value.rulehead.makefile
