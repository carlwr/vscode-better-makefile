# SYNTAX TEST "source.makefile"


# _do_ scope % and wildcards in function arguments - _some_ functions treat these as special, and if the user uses these characters in a function arg, chances are it is with such a function.

sr:=$(strip ab:%b=%)   ## /^sr := ab:%b=%/
#              ^  ^    constant.other.placeholder.percent.makefile

___$(or ,*): P
#        ^             variable.language.special.wildcard.makefile

t: $(or ,*)
#        ^             variable.language.special.wildcard.makefile
