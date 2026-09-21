# SYNTAX TEST "source.makefile"

# --------------------- within expansions --------------------- #


# raw ()s within $(exp)
# ---------------------

v_b0_ = a$(_____(#)_#)a #CMT      ## /^\Qv_b0_ = a$(_____(#)_#)a \E$/
v_b1 := a$(_____(#)_#)a #CMT      ## /^\Qv_b1 := a_#)a \E$/
#         [----------]            PARSING   : sees this clause
#                       """"      PARSING   : stripped
#        $(-------)               EVALUATION: expansion
#                  """"           EVALUATION: literal characters

# //¨¨¨¨ compare:
v_b3 := a$(____$(#)_#)a #CMT      ## /^\Qv_b3 := aa \E$/
#        $(----------)            EVALUATION: expansion
# ____//

# conclusions:
# - parsing:
#     (i.e. comment stripping)
#     tracks ()-s, whether raw or $(..)
# - evaluation: 
#     after `$(`, the first seen `)` closes the expansion
#     (even if a raw opening `(` was encountered along the way)

# scope tests:
T_b0 := a$(_____(#)_#)a #CMT)
#       ^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                       ^^^^      comment.line.number-sign.makefile

