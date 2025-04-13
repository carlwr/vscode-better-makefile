# SYNTAX TEST "source.makefile"

oo1: o1a | o1b
#        ^             punctuation.separator.key-value.order-only.makefile
## /\Qoo1: o1a | o1b/

oo2:  o2a|o2b
#        ^             punctuation.separator.key-value.order-only.makefile
## /\Qoo2: o2a | o2b/

oo3:|o3b
#   ^                  punctuation.separator.key-value.order-only.makefile
## /\Qoo3: | o3b/

oo4: o4a |
#        ^             punctuation.separator.key-value.order-only.makefile
## /oo4: o4a/

