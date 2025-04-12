.SHELLFLAGS +=  -eu -o pipefail
MAKEFLAGS   +=  --no-builtin-rules          \
                --warn-undefined-variables  \
                --jobs 6                    \
                --output-sync

TESTS   ?=
HUMAN   ?=
NOTRACE ?=
VERBOSE ?= 1
BAKSUFX ?=

json    :=  syntaxes/makefile.tmLanguage.json
yaml    :=       src/makefile.tmLanguage.yaml
testdir :=      test/grammar
bakdir  :=  ../.backup/vscode-better-makefile


# ------------------------------------------------------------- #
#                          rules: main                          #
# ------------------------------------------------------------- #

.PHONY:         \
  build         \
  backup        \
  test          \
  clean         \
  inspect.%


# dependencies
# ------------

build    : $(json)
$(json)  : $(yaml)
test     : \
  test-parse .WAIT \
  test-xfail .WAIT \
  test-xpass


# recipes
# -------

$(json):
	$(build)

backup: curdir != basename "$$PWD"
backup: suffix := $(if $(value BAKSUFX),_$(BAKSUFX),)
backup: f      := $(shell date "+%Y-%m-%d_%H.%M.%S")$(suffix).tgz
backup:
	@[ -d "$(bakdir)" ] || { echo no dir "$(bakdir)"; exit 1; }
	gtar czf "$(bakdir)/$f" --exclude-ignore=.backupignore -C .. "$(curdir)"
	@echo '\ncreated archive:' && ls -lh "$(bakdir)/$f"

clean:
	rm -f $(json)

inspect.%:
	@printf 'unevaluated: %s\n' '$(value $*)'
	@printf 'evaluated  : %s\n' '$($*)'


# ------------------------------------------------------------- #
#                          rules: tests                         #
# ------------------------------------------------------------- #

findTests    = $(shell find $(testdir) -ipath '*$(TESTS)*' -path '*.mk' $1)
parseTest   := test/grammar/scripts/parseTest

# lists of files:
xpass_files := $(call findTests,-not -name '*XFAIL*')
xfail_files := $(call findTests,     -name '*XFAIL*')
parse_files != $(parseTest) --files-with-tests $(xpass_files) $(xfail_files)

# lists of test targets:
xpass       := $(addprefix T_xpass_,$(xpass_files))
xfail       := $(addprefix T_xfail_,$(xfail_files))
parse       := $(addprefix T_parse_,$(parse_files))

.PHONY:         \
  test-xpass    \
  test-xfail    \
  test-parse    \
  test-xpass_do \
  test-xfail_do \
  test-parse_do \
  $(xpass)      \
  $(xfail)      \
  $(parse)


# dependencies
# ------------

test-xpass    : test-xpass_do
test-xfail    : test-xfail_do
test-parse    : test-parse_do
test-xpass_do : $(xpass)
test-xfail_do : $(xfail)
test-parse_do : $(parse)
$(xpass)      : $(json)
$(xfail)      : $(json)
$(parse)      : $(json)


# recipes
# -------

$(xpass) :\
T_xpass_%: %
	@$(call test,$<) >$(testoutTo) \
	  && $(call msg,ok  ,xpass,_      ,$(<F))\
	  || $(call msg,FAIL,xpass,_      ,$(<F))

$(xfail) :\
T_xfail_%: %
	@$(call test,$<) >/dev/null \
	  && $(call msg,WARN,xfail,passed:,$(<F))\
	  || $(call msg,exp ,xfail,_      ,$(<F))

$(parse) :\
T_parse_%: %
	@$(call print-make-db,$<) | $(parseTest) $< \
	  && $(call msg,ok  ,parse,_      ,$(<F))\
	  || $(call msg,FAIL,parse,_      ,$(<F))

test-xpass:; @$(call msg,done,_    ,(n=$(words $(xpass))),)
test-xfail:; @$(call msg,done,xfail,(n=$(words $(xfail))),)
test-parse:; @$(call msg,done,parse,(n=$(words $(parse))),)


# ------------------------------------------------------------- #
#                           functions                           #
# ------------------------------------------------------------- #

print-make-db = { $(MAKE) -nsp --always-make -f $1 2>/dev/null || true; }

testCmd := \
  $(strip \
    $(let gotTimeout,$(shell timeout --version 2>/dev/null|grep -o GNU), \
      $(if $(gotTimeout), timeout -v 6s pnpm exec vscode-tmgrammar-test  \
                        ,               pnpm exec vscode-tmgrammar-test   )))
  # for Makefile test invocations, don't use timeout-cli, since formatted terminal output from vscode-tmgrammar-test is then lost

ifdef NOTRACE
  testoutTo  := /dev/null
else
  testoutTo  := &1
endif

ifdef HUMAN
  build       = FORCE_COLOR=3 pnpm build
  test        = FORCE_COLOR=3 $(testCmd) $1|awk '! /run success/'
  color_FAIL := '$(shell tput setaf 1)'
  color_WARN := '$(shell tput setaf 3)'
  color_ok   := '$(shell tput setaf 2)'
  color_exp  := '$(shell tput setaf 72)'
  color_done := '$(shell tput setaf 4; tput bold)'
  color_file := '$(shell tput setaf 0; tput sitm)'
  color_rst  := '$(shell tput sgr 0)'
else
  build       = FORCE_COLOR=0 pnpm build
  test        = FORCE_COLOR=0 $(testCmd) --compact $1|awk '! /run success/'
  color_FAIL := ''
  color_WARN := ''
  color_ok   := ''
  color_exp  := ''
  color_done := ''
  color_file := ''
  color_rst  := ''
endif

msg = \
  $(strip \
    $(let s type note file,$1 $2 $3 $4,\
      $(if $(filter-out FAIL WARN ok exp done,$s),$(error msg: invalid)) \
      if [ "$s" != ok -a "$s" != exp ] || [ -n "$(VERBOSE)" ]; \
      then \
        { printf '[%s%-4s%s %-5s] %-7s  %s%s%s\n%s' \
          $(color_$s) $s $(color_rst) \
          '$(type:_=)' \
          '$(note:_=)' \
          $(color_file) '$(file)' $(color_rst) \
          $(if $(filter done,$s),$$'\n'  ,'')  \
          $(if $(filter FAIL,$s),; exit 1,  ); \
        }\
      fi \
   ))
  # arguments:
  #
  #     s       (s)tatus enum; see source for valid values
  #     type    typically "xfail" or "_"
  #     note
  #     file
  #
  #     (`type`, `note`: may not pass ""; use "_")
