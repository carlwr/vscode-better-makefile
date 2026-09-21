# SYNTAX TEST "source.makefile"


# ----------------------- non-expansions ---------------------- #

# no expansion; just string with delimiters
# -> no delimiter counting; first # starts a comment

# mapping-out full behaviour
# --------------------------

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

# some selected tests
# -------------------

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
