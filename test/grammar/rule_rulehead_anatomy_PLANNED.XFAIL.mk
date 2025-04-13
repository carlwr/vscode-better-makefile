# SYNTAX TEST "source.makefile"


# ------------------------------------------------------------- #
#                     background, motivation                    #
# ------------------------------------------------------------- #

# identifying analogous parts:

_  _trg: %trg: %dep    # static-pat.
_  _trg:       _dep    # expl.
   ####        ####

_  _trg: %trg: %dep    # static-pat.
_        %trg: %dep    # pat.
         ####  ####

_  _trg:       _dep    # expl.
_  %trg:       %dep    # pat.
   ####        ####


# ------------------------------------------------------------- #
#                           -> scopes                           #
# ------------------------------------------------------------- #


# ----------------------- explicit rule ----------------------- #

_  _trg:       _dep    # expl.
#  ^^^^                meta.scope.rule.head.target
#              ^^^^    meta.scope.rule.head.prereq
#      ^^    ^^        meta.scope.rule.head.other

#  ^^^^                entity.name.function.target.static-pat.expl


# ------------------------ pattern rule ----------------------- #

_        %trg: %dep    # pat.
#        ^^^^          meta.scope.rule.head.target
#              ^^^^    meta.scope.rule.head.prereq
#      ^^    ^^        meta.scope.rule.head.other

#        ^^^^          entity.name.function.target


# -------------------- static-pattern rule -------------------- #

_  _trg: %trg: %dep    # static-pat.
#  ^^^^                meta.scope.rule.head.target.static-pat.expl
#        ^^^^          meta.scope.rule.head.target.static-pat.patt
#              ^^^^    meta.scope.rule.head.prereq.static-pat.prrq
#      ^^    ^^        meta.scope.rule.head.other.static-pat

#  ^^^^                entity.name.function.target.static-pat.expl
#        ^^^^          entity.name.function.target.static-pat.patt


# as a consequence of the above, the following less specific scopes will be matched:
 # targ: %trg: %dep
 # ^^^^^^^^^^^^^^^^    meta.scope.rule.head



