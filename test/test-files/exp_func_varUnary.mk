# SYNTAX TEST "source.makefile"


v := $(flavor var)
#      ^^^^^^             support.function.flavor.makefile
#             ^^^         variable.other.makefile

v := $(origin var)
#             ^^^         variable.other.makefile
#      ^^^^^^             support.function.origin.makefile

v := $(flavor)
#      ^^^^^^           - support.function.flavor.makefile

v := $(origin _$(vvv)_)
#             ^  ^^^ ^    variable.other.makefile
#              ^^   ^   - variable.other.makefile
#      ^^^^^^             support.function.origin.makefile
#      ^^^^^^^^^^^^^^^    meta.function-call.makefile
#      ^^^^^^^^^^^^^^^    meta.scope.expansion.makefile

v := ${origin _$(vvv)_}
#             ^  ^^^ ^    variable.other.makefile
#              ^^   ^   - variable.other.makefile
#      ^^^^^^             support.function.origin.makefile
#      ^^^^^^^^^^^^^^^    meta.function-call.makefile
#      ^^^^^^^^^^^^^^^    meta.scope.expansion.makefile

v := ${origin _$(vvv)_}
#             ^  ^^^ ^    variable.other.makefile
#              ^^   ^   - variable.other.makefile
#      ^^^^^^             support.function.origin.makefile
#      ^^^^^^^^^^^^^^^    meta.function-call.makefile
#      ^^^^^^^^^^^^^^^    meta.scope.expansion.makefile
