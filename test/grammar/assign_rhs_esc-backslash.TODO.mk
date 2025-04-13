# SYNTAX TEST "source.makefile"

# for raw strings, such as RHS in assignment, a backslash can quote:
# - \#
# - \<nl> (line cont.)
# - itself for the two forms above





a0_ = aa \ b
a1_ = a \c b
a2_ = a \\ b

v_a0_ = $(a0_)
v_a1_ = $(a1_)
v_a2_ = $(a2_)

$(info _$(a0_)_,_$(value a0_)_)
$(info _$(a1_)_,_$(value a1_)_)
$(info _$(a2_)_,_$(value a2_)_)

$(info _$(v_a0_)_,_$(value v_a0_)_)
$(info _$(v_a1_)_,_$(value v_a1_)_)
$(info _$(v_a2_)_,_$(value v_a2_)_)


_var1 = a\b     ## /\Q_var1 = a\b/
_trg1_: a\b     ## /\Q_trg1_: a\b/
_var2 = \\b     ## /\Q_var2 = \\b/
_var3 = a\      ## /\Q_var3 = a\ /


