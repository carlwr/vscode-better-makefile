# SYNTAX TEST "source.makefile"

# (this fail may include duplicates of what is in non-XFAIL test files, for symmetry/completeness)


# --------- spurious non-exp. delim not of outer type --------- #

# ...do not keep the outer exp. delims open, or cause issues:

# similar, function:
v_h0_ = a$(or {,_#)a #CMT    ## /v_h0_ = a\$\(.*\)a $/
v_h1 := a$(or {,_#)a #CMT    ## /v_h1 := a{a $/
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#                    ^^^^       comment.line.number-sign.makefile

# note that if the inner delim is of the outer type, that _does_ create a nested context - this is illustrated elsewhere in this file, and again here with the same form that is used above:
v_c3 := a$(___(__#)a #CMT    ## /v_c3 := a.*a #CMT .*/


# ------- outermost delim type determines inner tracking ------ #

# the type of the outermost expansion determines whether ()s or {}s are tracked - inner expansions of another type does not consume delimiters of the outer type w.r.t. tracking balanced delimiters:
v_d0A:= a${________{xxxxx}____#}a #CMT   ## /v_d0A := a.*a $/
v_d1A:= a${_______${xxxxx}____#}a #CMT   ## /v_d1A := a.*a $/
v_d2A:= a${______$({)xxxx}____#}a #CMT   ## /v_d2A := a.*a $/
v_d3A:= a${________{xxx$(})___#}a #CMT   ## /v_d3A := a.*a $/
v_e0A:= a${___$(or {,x)xx}____#}a #CMT   ## /v_e0A := a.*a $/
v_e0E:= a${_$(or x,{,x)xx}____#}a #CMT   ## /v_e0E := a.*a $/
# (functions.c -> handle_functions())


T_d0 = a${________{xxxxx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile
T_d1 = a${_______${xxxxx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile
T_d2 = a${______$({)xxxx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile
T_d3 = a${________{xxx$(})___#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_e0 = a${___$(or {,,)xx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_f0 = a${or _____{xxxxx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_f4 = a${or $(or {,,)xx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile


# ------------ function call as the outer expansion ----------- #

# the outer expansion is a function call: still the same:
v_f0 = a${or _____{xxxxx}____#}a #CMT   ## /v_f0 = a.*a $/
v_f1 = a${or ____${xxxxx}____#}a #CMT   ## /v_f1 = a.*a $/
v_f2 = a${or ___$({)xxxx}____#}a #CMT   ## /v_f2 = a.*a $/
v_f3 = a${or _____{xxx$(})___#}a #CMT   ## /v_f3 = a.*a $/
v_f4 = a${or $(or {,,)xx}____#}a #CMT   ## /v_f4 = a.*a $/

# note that this has e.g. this consequence:
v_g0 = $(if y,_,n)a #CMT ) #cmt     ## /v_g0 = .*a $/
v_g1 = $(if y,{,n)a #CMT ) #cmt     ## /v_g1 = .*a $/
v_g2 = $(if y,(,n)a #CMT ) #cmt     ## /v_g2 = .*a #CMT \) $/  # <---

