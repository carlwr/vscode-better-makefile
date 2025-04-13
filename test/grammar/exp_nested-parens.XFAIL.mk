# SYNTAX TEST "source.makefile"



# main ref.: expand.c -> expand_string_buf()

# about below tests
# -----------------
#
# v_?? = ..    parse assert tests to verify make behaviour
# T_?? = ..    selected scope tests


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

 


# raw {}s within $()
# ------------------

v_i0_ = a$(_{#}_#)a #CMT      ## /^\Qv_i0_ = a$(_{#}_#)a \E$/
v_i1 := a$(_{#}_#)a #CMT      ## /^\Qv_i1 := aa \E$/
#         [------]            PARSING   : sees this clause
#                   """"      PARSING   : stripped
#        $(      )            EVALUATION: expansion
#                 "           EVALUATION: literal characters

T_i0_ = a$(_{#}_#)a #CMT
#       ^^^^^^^^^^^         - comment.line.number-sign.makefile
#                   ^^^^      comment.line.number-sign.makefile



# --------- spurious non-exp. delim not of outer type --------- #

# ...do not keep the outer exp. delims open, or cause issues:

# ------tested in .passing
v_c0 := a$(___{__#)a #CMT    ## /v_c0 := a.*a $/
v_c1 := a$(___}__#)a #CMT    ## /v_c1 := aa $/
# ------

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


v_e0F:= a${A$(if {,t,-)X}Y#}a #CMT   ## /v_e0F := a.*a $/
#v_e0D:= a${B$(if (,t,-)X}Y#)a #CMT

# runtime error, unterminated call to if:
#v_e0B:= a${B$(if (,t,-)X}Y#)a #CMT
#v_e0C:= a${C$(if },t,-)X}Y#}a #CMT

# there's no concept of "escaping delimiters": in `\{`, `\` is just a character:
v_e1 := a${_______\{xxxxx}____#}a #CMT   ## /v_e1 := a.*a $/
v_e2 := a${________{xxxx\}____#}a #CMT   ## /v_e2 := a.*a $/
v_e3 := a${________{xxxxx}___#\}a #CMT   ## /v_e3 := a.*a $/


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




# ------------------------------------------------------------- #
#                              old                              #
# ------------------------------------------------------------- #

# (can be deleted in a while, probably nothing not covered above)

# EDIT: not sure about the below
#   I think with $(..) as the outer expansion type, within it (-s and )-s are just counted; i.e. {-s and }-s are not special inside.
#
#              here: is known the { was never closed
#              |  spurious } char
#              ▼  ▼
v_x0 = a$(.(_{_)..}.) #CMT   # /\Qv_x0 = a$(.(_{_)..}.) \E$/
v_x1 = a$(.{_(_}..).) #CMT   # /\Qv_x1 = a$(.{_(_}..).) \E$/
v_x2 = a$(_(_{_)#x) #CMT
v_x3 = a$(_(_{_(_}_)_}_)_}#x) #CMT


v_y3a_ = a-${i____{_____#j_}_k#l_}-a #CMT
v_y3b_ = a-${i_$(_{_)___#j_}_k#l_}-a #CMT
v_y3c_ = a-${i___${_{_}_#j_}_k#l_}-a #CMT

v_y3x := ---------------------

v_y4a := a-${i____{_____#j_}_k#l_}-a #CMT
v_y4b := a-${i_$(_{_)___#j_}_k#l_}-a #CMT
v_y4c := a-${i___${_{_}_#j_}_k#l_}-a #CMT






v_z2a = a_____$(_{#.#)__a #CMT
v_z2b = a_____$(_.#}#)__a #CMT
v_z4a = __${_$(_{#.#)#}#}a #CMT
v_z5a = a__${_$(_.#}a # #CMT
v_z6a = a${_(_$(_{#.#)#}_#_)#_}a #CMT
v_z6b = a${_)_$(_{#.#)#}_#_)#_}a #CMT




