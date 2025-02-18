v = ${v__a_r}str  # cmt

targ: prereq
  echo $@

# setting built-in vars:
SHELL          = /bin/sh
MAKEFLAGS     := --no-builtin-rules         \
                 --warn-undefined-variables \
                 --no-print-directory
VPATH          = /home/user/src:/home/root/src:$(HOME)/dev

# built-in vars:
v = $(MAKECMDGOALS)
v = $(MAKE_TERMOUT)
v = $(MAKEOVERRIDES)
v = $(VPATH)
v = $(GPATH)
v = $(MAKELEVEL)
v = $(MAKE_VERSION)
v = $(MAKE_HOST)

v = $(MAKE_TERMERR)  # parens
v = ${MAKE_TERMERR}  # BRACES
v = $(MAKE_RESTARTS) # parens
v = ${MAKE_RESTARTS} # BRACES

# expanding built-in vars:
str := pre_$(SHELL)_$(user_defined)_$(CAPS_USERDEF)_post

# CURDIR is effectively a constant; setting it has no effect:
str2 := some $(CURDIR)


# various escapes
# ---------------

v != echo $$dollar

tgt: ____#

tgt: ___\#
tgt: ___\\#
#      ^  escapED character - no special scope (=scope of underlying scope)
#     ^ escape character

t: _\\\#

t: \\\\#   # desired: the pairing visible + the two \-s distinct


targ_%:
#    ^     placeholder
tar\\%:
#    ^     placeholder
#  ^       escape backslash
#   ^      target

targ\%:
#    ^     target
#   ^      escape backslash
ta\\\%:
#    ^     target
#   ^      escape backslash
#  ^       escape backslash
#   ^      target


t____%uu: p   # desired: %, \% and \\ all distinct
t___\%uu: p
t__\\%uu: p
t_\\\%uu: p
t\\\\%uu: p


__%__%__: p
_\%_\%__: p
_\%_\%__ _\%_\%__: p

__%%__: p
__%\%\__: p


t: ____%   # desired: %, \% and \\ all distinct
t: ___\%
t: __\\%
t: _\\\%
t: \\\\%

t: ____*
t: ___\*
t: __\\*
t: _\\\*
t: \\\\*

t: ____*%
t: ___\*%
t: __\\*%
t: _\\\*%
t: \\\\*%

#example practical use:
*.o: %.o: %.c

targ: pre*


# ------ copied from the GNU make manual ------
var = val
var ?= val
var := val
var ::= val
var :::= val
var += val
var != val
define var
  val
endef
define var =
  val
endef
define var ?=
  val
endef
define var :=
  val
endef
define var ::=
  val
endef
define var :::=
  val
endef
define var +=
  val
endef
define var !=
  val
endef
# ------


c      =  heyy
c     !=  heyy
var   :=  hey
vax   +=  ho$(var)
nest  ?=  pre_$(var$(vax))_post$$PATH $${fpath}
vux    =  $(if  $1     ,doit $2,doelse $3)
vux    =  $(if  $@     ,doit $2,doelse $3)
vux    =  $(if $(SHELL),doit $2,doelse $3)
shCmd !=  someCommand --opt
dbl   ==  str  # dbl is '=  str'
files  =  *
 iles  =  leading-space-var
tight__=var
empty  =
empty  =#
var  ::= val  # grammar bug (is valid assignment)
var :::= val  # grammar bug (is valid assignment)

# substitution references:
v = $(v:x=y)      # equivalent to $(v:%x=%y)
v = $(v:%x=%y)    # % at beginning
v = $(v:x%=y%)    # % at end
v = $(v:x%x=y%y)  # % within

v = $(v:x)  # not a subst. ref., but a variable named "v:x"

myval  = $(call myfunc,first arg,secondArg)
myval2 = $(patsubst first_arg,secondArg)
myval3 = $(noSuch first_arg,secondArg)
myval4 = char is  $c   # expanding single-char var
myval5 = char is $(c)  # expanding single-char var

var = $(exp)_str
var = $c_str
var = $@_str
var = $c
var = $@
var = $#
var = $#

var = $(SHELL)
var = $(SHELL )
  # grammar bug:
  #   GNU make: not var SHELL, but some var 'SHELL '
  #   grammar : built-in var SHELL

# ---
v = $    # grammar bug: make sets v to char '$'
# ---

cont   = pre_\
post
cont   = pre_ \
post

define def
strings
here
lastLine_$${fpath}
endef

define v= # grammar bug; = shouldnt be part of name
strings
endef

define v =
strings
endef

override define u =
strings
endef


define v =
#NOTcmt
endef

# nested define:
define a
define b
  body
endef
endef


undefine var

name$(expansion) := value
name$(MAKEFLAGS) := value
name$a           := value

# grammar bug: not recognized as assignments:
$(expansion)     := value
$(MAKEFLAGS)     := value
$a               := value
pre$(MAKEFLAGS)  := value


myfunc = echo $(SHELL) $(userVar) $1 $2 $@
useLet = $(let var0 var1,$1 longString,echo str $(var0) $3 $(SHELL))


# ----- variable boundaries:
exclm!!=shellCmd
  # grammar: 'exclm!' is a var name
  # (but not sure if make agrees)
# -----


# ----- not variables:
= not = var
a b   = c
var ??= value
	var = val  # leading tab
NOT_var\
is__var := value
# -----

# expanding vars:
# (below is according to grammar)
v = $($(var))str  # cmt
v = $(v__a_r)str  # cmt
v = ${v__a_r}str  # cmt
v = $(v$(a)r)str  # cmt
v = $(v${a}r)str  # cmt
v = ${v$(a)r}str  # cmt
v = ${v${a}r}str  # cmt
v = $((va_r))str  # illegal
v = $(($(r)))str  # illegal
v = $(var(name)  # name is 'var(name'
v = $(var)NOT)
v = $(var
NOTname)
v = ${var
NOTname}
v = $(var\
name)
v = ${var\
name}
v = $(va$(r\
n)ame)
v = $(va${r\
n}ame)
v = $(va(r\
name)NOT)

# functions:
v = $(sort a b c d)str
v = ${sort a b c d}str
v = $(sort * b c d)str
v = ${sort * b c d}str
v = $(sort $(ab) d)str
v = ${sort $(ab) d}str
v = $(sort a $(sort b c) d)
v = $(sort a $(sort *  ) d)
v = $(sort a $(sort %  ) d)

v = $(words a b)

# origin/flavor function
# ----------------------
# (known to take a _variable_ as (single) argument)

v = $(origin var)
v = $(flavor var)
v = $(sort   STR) # for comparison

# expansion in argument:
v = $(origin var$(var2))

# multiple arguments:
v = $(origin var var2)  # `origin` not scoped as a built-in
  # (haven't checked if consistent with GNU make or not)

# single argument, but a nested expansion contains a space:
v = $(origin var$(sort STR)) # `origin` not scoped as a built-in
  # -> grammar bug


# comments
# --------

# comment
 #   space + comment
   # spaces + comment

v = x  #       comment
v = x  \#      NOT comment
v = x  \\#     comment
v = x  \\\\#   comment
v = x  \\\\\#  NOT comment

# verified GNU make behaviour:
$(info _$(u#v)_)       # expands var named 'u#v'
v =     $(u#v)         # expands var named 'u#v'
v =     $(u\#v)        # expands var named 'u#v'
$(info a # b)          # prints   "a # b"
$(info $(sort a # b))  # prints   "# a b"
v = $(sort a # b)      # v set to "# a b"


# directives
# ----------

override LESSOPEN='| <%s|head|cowsay'
export   var
export   var := ho

ifeq (1,1)
$(info message text)
var = val

else-target: else-prereq
	gcc else-recipe

else
	$(warning preceding tab)
  $(error   preceding spaces)

else-target: else-prereq
	gcc else-recipe

endif

$(eval something)

$(info var is a $(flavor var))


vpath %.c /tmp
vpath

include other.mk
-include other2
sinclude other2

# load:
load     f.o g.o
load     f.o g.o(symbolName)end
load     f.o g.o(symbol$(ref)name)end
load     $(name).o
-load    f.o g.o
sload    f.o    # "sload" is _not_ special, i.e. different from include
# "load" is a valid target name (ref: read.c)
load: prereq  # grammar bug
	gcc


# rules
# -----

.DEFAULT_GOAL := all

.DEFAULT: all
.PHONY: all
all: targ

.PHONY: interpolate_$(SHELL)

## docstring-like for targ
targ: prereq
	# $@:
	echo 'hey' $$PATH
	someCmd file0 \
          file1
	someCommand --someOpt -f file1
	$(MAKE) --recursive invocation

main.o: main.c
	c      $(SHELL)
	c       $@
	c $(if $(SHELL),,)
	c $(if  $@,,)
	c $(if $(@),,)
	$(GCC) $$env  $(SHELL)              $(var) -C $(@D) $@ $<
	c $(call func,$(SHELL)) $(call func,$(var))
	c $(dir       $(SHELL)) $(dir       $(var))
	var=value  # shell variable

# comment for main.o
main.o: variable = value
main.o: private variable = value
main.o: main.c
	$(GCC) $$envVar $(SHELL) $(makevar) -C $(@D) $@ $<

targ2: prereq2
	gcc --switch

# two spaces, not a tab, as recipe prefix:
targ2: prereq2
  gcc --switch

t: p0 \= p1  # prereqs with "=" in filename
t: p\=p      # prereqs with "=" in filename

t0 t1: p0 p1
	gcc --switch

# currently a grammar bug:
t0\
	this: is tab-indented
	tab-indented

t0\
  this: is SPACE-indented
	tab-indented


t0 t1: p0\
p1
	gcc --switch

t0 t1: p0\
	p1
	# above: tab-indented
	gcc --switch

t0 t1: p0\
  p1
	# above: space-indented
	gcc --switch


%.o: %.c
	recipe


# these are equivalent; GNU make treats \% as %:
%.o  : %.c  ; recipe
\%.o : \%.c ; recipe


# pattern rules may have multiple targets; all must have a % character:
%.o %.ext: %.c
	recipe

static-pat-targ: %.targ-pat: %.prereq-pat
	recipe

static-pat-targ: \
%.targ-pat: %.prereq-pat
	recipe


targ0 targ1: targ%: prereq%
	r; note: targ% must match all targets

test.o db.o: \
%.o: %.c
	$(GCC) -C $(@D) $@ $<

# grammar bug: * not constant.other.placeholder:
*.pdf: f.tex
	latex

a.*: p
	rec

main.pdf: *.tex
	latex

targ: prereq; command --inline-recipe

t0 t1 &: p0

t0 : p0 | order-only
t0 :    | order-only
t0 :| order-only

# grammar problem: rule not recognized if first char of target is not alphanumeric:
$(targ)     : $(prereq).ext   # WRONG
$(targ).ext : $(prereq).ext   # WRONG
t$(arg)     : $(prereq)       # ok
t$(arg)     : $(prereq).ext   # ok

clean:
	@echo msg1
	@echo msg2
	@echo '(Nothing to clean)'
	@echo msg3
	+@echo always-message

.PHONY:\
  all        \
  install    \
  uninstall  \
  clean

.NOTINTERMEDIATE:
.NOTINTERMEDIATE: main.o

.INTERMEDIATE:
.INTERMEDIATE: main.obj


#
# realistic in-the-wild makefile
# ------------------------------

MAKEFLAGS   := $(MAKEFLAGS) --no-builtin-rules

prefix      ?=  /usr/local
destdir     ?=
INSTALL     ?=  install -m 0755

# derived variables:
bindir      ?=  $(prefix)/bin
instdir      =  $(destdir)$(bindir)


all: main

main: main.o
	gcc -o $@ $<

%.o: %.c
	gcc -c -o $@ $<

main.c: main.m4 defs.m4
	@echo Creating $@:
	m4 $< > $@

install: main
	mkdir -p $(instdir)
	$(INSTALL) $< $(instdir)/$<

uninstall:
	rm -f $(instdir)/main

clean:
	rm main main.o
	@echo

.PHONY: \
  all        \
  install    \
  uninstall  \
  clean


#
# nested ()s, {}s
# ---------------

# (invalid make syntax -> parsing might fail so keep at the end of the file)

# verified GNU make behaviour:
# function calling:
#[-----line to GNU make----]#   #[----prints----]#
$(info a(b---)c) #cmt1) #cmt2   # a(b---)c
$(info a(b---_c) #cmt1) #cmt2   # a(b---_c) #cmt1
$(info a(b(x))c) #cmt1) #cmt2   # a(b(x))c
$(info a(b(x_)c) #cmt1) #cmt2   # a(b(x_)c) #cmt1
  # comments:
  # - GNU make keeps track of balanced parentheses in the strings
  # - the grammar, my understanding: this is supposed to be handled by the grammar rule named "interpolation"
#
# variable assignment:
#[-----line to GNU make--]#   #[-v? assigned to-]#
v0 = a(b---)c) #cmt1) #cmt2   # a(b---)c)
v1 = a(b---_c) #cmt1) #cmt2   # a(b---_c)
v2 = a(b(x))c) #cmt1) #cmt2   # a(b(x))c)
v3 = a(b(x_)c) #cmt1) #cmt2   # a(b(x_)c)
