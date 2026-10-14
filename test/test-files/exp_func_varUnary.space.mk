# SYNTAX TEST "source.makefile"


# negatives
# ---------

# `flavor`/`origin` should be followed by exactly _one_ word (= variable name). If it isn't, `flavor`/`origin` should not be scoped as a function. This is a design choice of the grammar independent of what GNU make's actual behaviour is (since: the grammar assumes users to intend to use these functions only with a single variable).
#
# For !=1 words, choose not to test actual scoping of the function or the words; prefer to leave that unspecified by the tests.

v := $(flavor )
#      ^^^^^^           - support.function.flavor.makefile
v := $(flavor  )
#      ^^^^^^           - support.function.flavor.makefile
v := $(flavor v r)
#      ^^^^^^           - support.function.flavor.makefile
v := $(origin v r)
#      ^^^^^^           - support.function.origin.makefile
