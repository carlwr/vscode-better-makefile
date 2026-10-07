# SYNTAX TEST "source.makefile"


fe= $(foreach var,list,text)
#     ^^^^^^^^^^^^^^^^^^^^^    meta.scope.expansion.makefile
#     ^^^^^^^^^^^^^^^^^^^^^    meta.function-call.makefile
#     ^^^^^^^                  support.function.foreach.makefile
#     ^^^^^^^                - meta.function-call.arguments.makefile
#             ^^^ ^^^^ ^^^^    string.unquoted.makefile
#             ^^^ ^^^^ ^^^^    meta.function-call.arguments.makefile
