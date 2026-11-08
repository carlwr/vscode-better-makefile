# SYNTAX TEST "source.makefile"

# --------------------- within expansions --------------------- #


# raw {}s within $()
# ------------------

v_i0_ = a$(_{#}_#)a #CMT          ## /^\Qv_i0_ = a$(_{#}_#)a \E$/
v_i1 := a$(_{#}_#)a #CMT          ## /^\Qv_i1 := aa \E$/
#         [------]                PARSING   : sees this clause
#                   """"          PARSING   : stripped
#        $(      )                EVALUATION: expansion
#                 "               EVALUATION: literal characters

T_i0_ = a$(_{#}_#)a #CMT
#       ^^^^^^^^^^^             - comment.line.number-sign.makefile
#                   ^^^^          comment.line.number-sign.makefile

T_i1:= a$(_{#}_#)a #CMT
#      ^^^^^^^^^^^              - comment.line.number-sign.makefile
#                  ^^^^           comment.line.number-sign.makefile


# raw ()s within $(<func> ..)
# ---------------------------

v_j0_ = a$(or x,(#)_#)a #CMT      ## /^\Qv_j0_ = a$(or x,(#)_#)a \E$/
v_j1 := a$(or x,(#)_#)a #CMT      ## /^\Qv_j1 := axa \E$/
#        $(----------)            EVALUATION: expansion

v_k0_ = a$(or x,{#}_#)a #CMT      ## /^\Qv_k0_ = a$(or x,{#}_#)a \E$/
v_k1 := a$(or x,{#}_#)a #CMT      ## /^\Qv_k1 := axa \E$/
#        $(----------)            EVALUATION: expansion

# conclusions:
# - parsing:
#     as with var. expansion
# - evaluation: 
#     after `$(<func>`, balanced ()-s and {}-s are tracked when searching for the `)` closes the function expansion

T_j0_ = a$(or x,(#)_#)a #CMT
#       ^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                       ^^^^      comment.line.number-sign.makefile

T_k0_ = a$(or x,{#}_#)a #CMT
#       ^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                       ^^^^      comment.line.number-sign.makefile
