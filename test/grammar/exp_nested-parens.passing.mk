# SYNTAX TEST "source.makefile"

# TEMP TESTS
#    
#    __$(abcd:x)##
#    __${abcd:x}##
#    __$(a(cd:x)##
#    __${a(cd:x}##
#    $(${abcd:x)}##
#    __$(${}d:x)##
#    
#    
#    $($(abcd:x})##
#    __${abcd:x)##
#    __$(${}d:x}##


# most tests not passing; the .XFAIL file is the main file


# ----------------------- non-expansions ---------------------- #

# **everything here passing; not in .XFAIL file**

# no expansion; just string with delimiters
# -> no delimiter counting; first # starts a comment:
v_a0_ = a(b__x__c_#CMT    ## /^\Qv_a0_ = a(b__x__c_\E$/
v_a1_ = a_b__x__c)#CMT    ## /^\Qv_a1_ = a_b__x__c)\E$/
v_a2_ = a(b__x__c)#CMT    ## /^\Qv_a2_ = a(b__x__c)\E$/
v_a3_ = a(b_(x)_c)#CMT    ## /^\Qv_a3_ = a(b_(x)_c)\E$/
v_a4_ = a(b__x_)c)#CMT    ## /^\Qv_a4_ = a(b__x_)c)\E$/
v_a5_ = a(b_(x__c)#CMT    ## /^\Qv_a5_ = a(b_(x__c)\E$/
v_a6_ = a(b_(x))c)#CMT    ## /^\Qv_a6_ = a(b_(x))c)\E$/
v_a7_ = a(b((x)_c)#CMT    ## /^\Qv_a7_ = a(b((x)_c)\E$/
v_a8_ = a{b_(x)}c)#CMT    ## /^\Qv_a8_ = a{b_(x)}c)\E$/

v_a0 := a(b__x__c_#CMT    ## /^\Qv_a0 := a(b__x__c_\E$/
v_a1 := a_b__x__c)#CMT    ## /^\Qv_a1 := a_b__x__c)\E$/
v_a2 := a(b__x__c)#CMT    ## /^\Qv_a2 := a(b__x__c)\E$/
v_a3 := a(b_(x)_c)#CMT    ## /^\Qv_a3 := a(b_(x)_c)\E$/
v_a4 := a(b__x_)c)#CMT    ## /^\Qv_a4 := a(b__x_)c)\E$/
v_a5 := a(b_(x__c)#CMT    ## /^\Qv_a5 := a(b_(x__c)\E$/
v_a6 := a(b_(x))c)#CMT    ## /^\Qv_a6 := a(b_(x))c)\E$/
v_a7 := a(b((x)_c)#CMT    ## /^\Qv_a7 := a(b((x)_c)\E$/
v_a8 := a{b_(x)}c)#CMT    ## /^\Qv_a8 := a{b_(x)}c)\E$/


T_a0 = a(b__x__c_#CMT    
#                ^^^^       comment.line.number-sign.makefile
T_a1 = a_b__x__c)#CMT
#                ^^^^       comment.line.number-sign.makefile
T_a6 = a(b_(x))c)#CMT
#                ^^^^       comment.line.number-sign.makefile
T_a7 = a(b((x)_c)#CMT
#                ^^^^       comment.line.number-sign.makefile
T_a8 = a{b_(x)}c)#CMT
#                ^^^^       comment.line.number-sign.makefile


# with line-cont.:
T_a0C= a(b__x\
             __c_#CMT    ## /^T_a0C = a\(b__x\s*__c_$/
#                ^^^^       comment.line.number-sign.makefile


__ := )})}  # close any VS Code bracket matching state


# --------- spurious non-exp. delim not of outer type --------- #

# **everything here passing; some overlap with .XFAIL file**

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



# ----------------------------- - ----------------------------- #

# below is copy-paste of currently passing tests from the .XFAIL file:


# --------------------- within expansions --------------------- #

T_i1:= a$(_{#}_#)a #CMT
#      ^^^^^^^^^^^         - comment.line.number-sign.makefile
#                  ^^^^      comment.line.number-sign.makefile



v_d1 := a${_______${xxxxx}____#}a #CMT   ## /v_d1 := a.*a $/
v_d3 := a${________{xxx$(})___#}a #CMT   ## /v_d3 := a.*a $/
v_f0 := a${or _____{xxxxx}____#}a #CMT   ## /v_f0 := a.*a $/
v_f1 := a${or ____${xxxxx}____#}a #CMT   ## /v_f1 := a.*a $/

# DOING:
v_g2_ = $(if y,(,n)a #b)c#cmt     ##   /^v_g2_ = (?x).*  c  $/
v_g2 := $(if y,(,n)a #b)c#cmt     ## /^\Qv_g2 := (,n)a #bc\E$/

T_d1 = a${_______${xxxxx}____#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^      - comment.line.number-sign.makefile
#                                ^^^^   comment.line.number-sign.makefile

T_d3 = a${________{xxx$(})___#}a #CMT
#      ^^^^^^^^^^^^^^^^^^^^^^^^^         - comment.line.number-sign.makefile
#                                ^^^^      comment.line.number-sign.makefile
