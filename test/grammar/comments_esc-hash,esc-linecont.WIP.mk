# SYNTAX TEST "source.makefile"


# WIP: so far only parse tests to map out `make`s behaviour


_hash_0_ = 0           ## /^\Q_hash_0_ = 0        /
_hash_1_ = 1  \        ## /^\Q_hash_1_ = 1  \     /
_hash_1b = 1b \
cont                   ## /^\Q_hash_1b = 1b cont  /
_hash_2_ = 2  \#       ## /^\Q_hash_2_ = 2  #     /
_hash_3_ = 3  \\       ## /^\Q_hash_3_ = 3  \\    /

_hash_4a = 4a \\
                       ## /^\Q_hash_4a = 4a \\/
                       ##   /^_hash_4a = 4a ..$/
_hash_4b = 4b \\#      ## /^\Q_hash_4b = 4b \/
                       ##   /^_hash_4b = 4b .$/


_hash_8 = 8 \\\#     ## /^\Q_hash_8 = 8 \#    /  # why not \\#?


_hash_9 = 9 \\\\     ## /^\Q_hash_9 = 9 \\\\  /






func0 := $(if ,,a #str0  )  ## /\Qfunc0 := a #str0  /
func1 := $(if ,,a\#str1  )  ## /\Qfunc1 := a\#str1  /

# TODO:
# abcXX1 := val\u\#e
# abcXX2 := $(strip val\u#e)


# make -nps -f test/grammar/comments_escaped-hash.mk|grep _hash|cat -e|sort
