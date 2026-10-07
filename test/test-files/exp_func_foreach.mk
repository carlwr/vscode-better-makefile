# SYNTAX TEST "source.makefile"


fe= $(foreach var,list,text)
#     ^^^^^^^^^^^^^^^^^^^^^    meta.scope.expansion.makefile
#     ^^^^^^^^^^^^^^^^^^^^^    meta.function-call.makefile
#     ^^^^^^^                  support.function.foreach.makefile
