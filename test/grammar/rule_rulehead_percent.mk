# SYNTAX TEST "source.makefile"

%tgt: %pre
#<-   ^        constant.other.placeholder.percent.makefile
# ^^           entity.name.function.target.makefile
# ^^           meta.scope.targets.makefile
#     ^^^^     meta.scope.prerequisites.makefile

tgt%: pre%
#  ^     ^     constant.other.placeholder.percent.makefile
#^^            entity.name.function.target.makefile
# ^^           meta.scope.targets.makefile
#     ^^^^     meta.scope.prerequisites.makefile

%:
#<-            constant.other.placeholder.percent.makefile
#^             punctuation.separator.key-value.rulehead.makefile

%: p
#<-            constant.other.placeholder.percent.makefile
#<-            meta.scope.targets.makefile

$(v)_%: p
#^^^^^         meta.scope.targets.makefile
#   ^          entity.name.function.target.makefile
#    ^         constant.other.placeholder.percent.makefile

$(v)% $(v)%: p
#^^^^^^^^^^    meta.scope.targets.makefile
#   ^     ^    constant.other.placeholder.percent.makefile

__%_$c$c _%: p
#^ ^     ^     entity.name.function.target.makefile
#^^^^^^^^^^    meta.scope.targets.makefile
# ^       ^    constant.other.placeholder.percent.makefile
#    ^ ^       variable.other.makefile


# repeated %s
# -----------

# in pattern rules with >1 target or prereq, additional targets/prereqs may or may not have %s:
tmA_% tmB_%: p
#   ^     ^    constant.other.placeholder.percent.makefile
w:A_%   B_%
#   ^     ^    constant.other.placeholder.percent.makefile

# with two % in _the same_ target or prereq, preferrably only the first should be marked as special since `make` will consider the second a literal character - however, don't require that from the grammar; instead test only that with two % in a target/prereq the _first_ is still recognized.
%tg%: %pr%
#<-   ^        constant.other.placeholder.percent.makefile
#^^            entity.name.function.target.makefile
#^^^           meta.scope.targets.makefile
#     ^^^^     meta.scope.prerequisites.makefile

