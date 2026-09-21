# SYNTAX TEST "source.makefile"

# main GNU-make source: expand.c -> expand_string_buf()

# naming convention:
#   v_?? = ..    parse assert tests to verify make behaviour
#   T_?? = ..    selected scope tests


# --------- spurious non-exp. delim not of outer type --------- #

# delim of the other type, if unbalanced, is the literal character:
v_c0 := a$(___{__#)a #CMT    ## /v_c0 := a(?#    )a $/
v_c1 := a$(___}__#)a #CMT    ## /v_c1 := a(?#    )a $/
v_c0_ = a$(___{__#)a #CMT    ## /v_c0_ = a\$\(.*\)a $/
v_c1_ = a$(___}__#)a #CMT    ## /v_c1_ = a\$\(.*\)a $/

T_c0 := a$(___{__#)a #CMT
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#          ^^^^^^^              variable.other.makefile
#                    ^^^^       comment.line.number-sign.makefile
T_c1 := a$(___}__#)a #CMT
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#          ^^^^^^^              variable.other.makefile
#                    ^^^^       comment.line.number-sign.makefile

v_h1 := a$(or },_#)a #CMT    ## /v_h1 := a}a $/
v_h1_ = a$(or },_#)a #CMT    ## /v_h1_ = a\$\(.*\)a $/
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#                    ^^^^       comment.line.number-sign.makefile

# with substref:

T_c0a = a$(_:_{__#)a #CMT
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#                    ^^^^       comment.line.number-sign.makefile

T_c0b = a$(___{:_#)a #CMT
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#                    ^^^^       comment.line.number-sign.makefile

T_c0c = a$(___{:=#)a #CMT
#       ^^^^^^^^^^^^          - comment.line.number-sign.makefile
#                    ^^^^       comment.line.number-sign.makefile


# ------- outermost delim type determines inner tracking ------ #

T_d1:= a${_______${xxxxx}____#}a #CMT      ## /T_d1 := a.*a $/
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_d3:= a${________{xxx$(})___#}a #CMT      ## /T_d3 := a.*a $/
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_f0:= a${or _____{xxxxx}____#}a #CMT      ## /T_f0 := a.*a $/
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile

T_f1:= a${or ____${xxxxx}____#}a #CMT      ## /T_f1 := a.*a $/
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile


# ------------ function call as the outer expansion ----------- #

v_g2_ = $(if y,(,n)a #b)c#cmt     ##   /^v_g2_ = (?x).*  c  $/
#       ^^^^^^^^^^^^^^^^^       - comment.line.number-sign.makefile
#                        ^^^^     comment.line.number-sign.makefile

v_g2:=  $(if y,(,n)a #b)c#cmt     ## /^\Qv_g2 := (,n)a #bc\E$/
#       ^^^^^^^^^^^^^^^^^       - comment.line.number-sign.makefile
#                        ^^^^     comment.line.number-sign.makefile


# ---------------------------- misc --------------------------- #

# note: there's no concept of "escaping delimiters"
# ...in `\{`, `\` is just a character:
v_e1 := a${_______\{xxxxx}____#}a #CMT   ## /v_e1 := a.*a $/
v_e2 := a${________{xxxx\}____#}a #CMT   ## /v_e2 := a.*a $/
v_e3 := a${________{xxxxx}___#\}a #CMT   ## /v_e3 := a.*a $/

# runtime error, unterminated call to if:
#v_e0B:= a${B$(if (,t,-)X}Y#)a #CMT
#v_e0C:= a${C$(if },t,-)X}Y#}a #CMT
