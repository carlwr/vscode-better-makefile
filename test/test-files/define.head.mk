# SYNTAX TEST "source.makefile"


# ------------------- form in make database ------------------- #

# the form of `define`s in the make db is fragile to small changes:

define makedb_A
#
#
endef
# -> make db entry: ## /^define makedb_A/

define makedb_B
#
endef
# -> make db entry: ## /^makedb_B = #/

## THEREFORE: prefer parse assert regexes accepting either:
##
##     /^(define )?makedb_A(?(1)$|( =))/
##

# notes:
#   verify this form matches also makedb_B:
#     ## /^(define )?makedb_B(?(1)$|( =))/
#   explanation:
#     ( ?(1) $ | ( =) )
#       """"            IF group 1 matched
#            "          THEN the next position must match $ == EOL
#                """"   ELSE the next two positions must match ' ='


# --------------------------- basic --------------------------- #

define aaa
#^^^^^         keyword.control.define.makefile
#      ^^^     variable.other.assignment.makefile
endef
## /^(define )?aaa(?(1)$|( =))/

define bbb
#^^^^^         keyword.control.define.makefile
#      ^^^     variable.other.assignment.makefile
endef

define ccc =
#^^^^^         keyword.control.define.makefile
#      ^^^     variable.other.assignment.makefile
endef
## /^(define )?ccc(?(1)$|( =))/

define ddd=
#^^^^^         keyword.control.define.makefile
#      ^^^     variable.other.assignment.makefile
endef
## /^(define )?ddd(?(1)$|( =))/

define eee :=
#^^^^^         keyword.control.define.makefile
#      ^^^     variable.other.assignment.makefile
endef
## /^(define )?eee(?(1)$|( :=))/

# space before "define":"
  define f :=
# ^^^^^^       keyword.control.define.makefile
#        ^     variable.other.assignment.makefile
endef

define tght3?=
#           ^^   keyword.operator.assignment.makefile
endef

define NL-op
=
#<-            - keyword.operator.assignment.makefile
endef


# ------------------ all assignment operators ----------------- #

define op0    =
#             ^   keyword.operator.assignment.makefile
endef
define op1   !=
#            ^^   keyword.operator.assignment.makefile
endef
define op2   +=
#            ^^   keyword.operator.assignment.makefile
endef
define op3   ?=
#            ^^   keyword.operator.assignment.makefile
endef
define op4   :=
#            ^^   keyword.operator.assignment.makefile
endef
define op5  ::=
#           ^^^   keyword.operator.assignment.makefile
endef
define op6 :::=
#          ^^^^   keyword.operator.assignment.makefile
endef


# -------------------------- comments ------------------------- #

define cmtAA#cmt
#           ^^^^ comment.line.number-sign.makefile
#      ^^^^^     variable.other.assignment.makefile
endef

define cCont#c\
 # still comment
#^^^^^^^^^^^^^^^ comment.line.number-sign.makefile
endef

define cCon2#c\
 # $(not-exp)
#^^^^^^^^^^^^    comment.line.number-sign.makefile
#    ^^^^^^^   - variable.other.makefile
endef


# ----------- variable name characters, assign. op. ----------- #

define plu+s
#      ^^^^^       variable.other.assignment.makefile
#
endef
## /^(define )?plu\+s(?(1)$|( =))/

define plus2+=
#      ^^^^^       variable.other.assignment.makefile
#           ^^     keyword.operator.assignment.makefile
endef
## /^(define )?plus2(?(1)$|( \+=))/

define exc!l
#      ^^^^^       variable.other.assignment.makefile
#
endef
## /^(define )?exc!l(?(1)$|( =))/

define excl2!=
#      ^^^^^       variable.other.assignment.makefile
#           ^^     keyword.operator.assignment.makefile
endef
## /^(define )?excl2(?(1)$|( =))/
##                           |--> NOTE: as '=', not '!=', in make db

define ques?tion
#      ^^^^^^^^^   variable.other.assignment.makefile
#
endef
## /^(define )?ques\?tion(?(1)$|( =))/

define question2?=
#      ^^^^^^^^^   variable.other.assignment.makefile
#               ^^ keyword.operator.assignment.makefile
endef
## /^(define )?question2(?(1)$|( \?=))/

define col:on
#      ^^^^^^      variable.other.assignment.makefile
#
endef
## /^(define )?col:on(?(1)$|( =))/

define colon:
#      ^^^^^^      variable.other.assignment.makefile
endef
## /^(define )?colon:(?(1)$|( =))/
# extra verification that the above defines a variable named "colon:":
    colon_var := _$(colon:)_
    ## /^colon_var := _#.*/

define dcol::
#      ^^^^^^      variable.other.assignment.makefile
endef
## /^(define )?dcol::(?(1)$|( =))/

define dceq::=
#      ^^^^        variable.other.assignment.makefile
#          ^^^     keyword.operator.assignment.makefile
endef
## /^(define )?dceq(?(1)$|( :+=))/
##                           |--> not sure of exact op. in make db

define tceq:::=
#      ^^^^        variable.other.assignment.makefile
#          ^^^^    keyword.operator.assignment.makefile
endef
## /^(define )?tceq(?(1)$|( :+=))/
##                           |--> not sure of exact op. in make db

define tc:::
#      ^^^^^       variable.other.assignment.makefile
endef
## /^(define )?tc:::(?(1)$|( =))/

define and&:
#      ^^^^^       variable.other.assignment.makefile
endef
## /^(define )?and&:(?(1)$|( =))/


# ---------------------- ...with comments --------------------- #

define cmt1:=#CMT
#      ^^^^        variable.other.assignment.makefile
#            ^^^^  comment.line.number-sign.makefile
#          ^^      keyword.operator.assignment.makefile
endef
## /^(define )?cmt1(?(1)$|( :=))/

define cmt2= #CMT
#      ^^^^        variable.other.assignment.makefile
#            ^^^^  comment.line.number-sign.makefile
endef
## /^(define )?cmt2(?(1)$|( =))/

define cmt3#CM:=T
#      ^^^^        variable.other.assignment.makefile
#          ^^^^^^  comment.line.number-sign.makefile
endef
## /^(define )?cmt3(?(1)$|( =))/


# ---------------------- override define ---------------------- #

override define ov1
#^^^^^^^               keyword.control.override.makefile
#        ^^^^^^        keyword.control.define.makefile
#               ^^^    variable.other.assignment.makefile
endef

  override define ov2
# ^^^^^^^^             keyword.control.override.makefile
#          ^^^^^^      keyword.control.define.makefile
#                 ^^^  variable.other.assignment.makefile
endef

override  define  ov3
#^^^^^^^               keyword.control.override.makefile
#         ^^^^^^       keyword.control.define.makefile
#                 ^^^  variable.other.assignment.makefile
endef

override define ov4 =
#^^^^^^^               keyword.control.override.makefile
#        ^^^^^^        keyword.control.define.makefile
#               ^^^    variable.other.assignment.makefile
#                   ^  keyword.operator.assignment.makefile
endef

override define ov5 = # (comment == force space after)
#^^^^^^^               keyword.control.override.makefile
#        ^^^^^^        keyword.control.define.makefile
#               ^^^    variable.other.assignment.makefile
endef

overridedefine =
#^^^^^^^             - keyword.control.override.makefile
#       ^^^^^^       - keyword.control.define.makefile
#^^^^^^^^^^^^^         variable.other.assignment.makefile
