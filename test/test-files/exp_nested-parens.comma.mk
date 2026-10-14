# SYNTAX TEST "source.makefile"


# ----------- nested parens in funcs protect commas ----------- #

v_g2C:=  $(if y,(,n)a #b)c#cmt     ## /^\Qv_g2C := (,n)a #bc\E$/
#                ^               - punctuation.separator.delimiter.comma.function.makefile
