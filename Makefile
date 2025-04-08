.SHELLFLAGS +=  -eu -o pipefail
MAKEFLAGS   +=  --no-builtin-rules          \
                --warn-undefined-variables  \
                --jobs 6                    \
                --output-sync

TESTS   ?=
HUMAN   ?=
NOTRACE ?=

json    :=  syntaxes/makefile.tmLanguage.json
yaml    :=       src/makefile.tmLanguage.yaml
testdir :=      test/grammar


# ------------------------------------------------------------- #
#                          rules: main                          #
# ------------------------------------------------------------- #

.PHONY:         \
  build         \
  test          \
  clean         \
  inspect.%


# dependencies
# ------------

build    : $(json)
$(json)  : $(yaml)
test     : \
  test-xpass


# recipes
# -------

$(json):
	$(build)

clean:
	rm -f $(json)

inspect.%:
	@printf 'unevaluated: %s\n' '$(value $*)'
	@printf 'evaluated  : %s\n' '$($*)'


# ------------------------------------------------------------- #
#                          rules: tests                         #
# ------------------------------------------------------------- #

findTests    = $(shell find $(testdir) -ipath '*$(TESTS)*.mk' $1 -print)

# lists of files:
xpass_files := $(call findTests,-not -name '*XFAIL*')

# lists of test targets:
xpass       := $(addprefix T_xpass_,$(xpass_files))

.PHONY:         \
  test-xpass    \
  test-xpass_do \
  $(xpass)


# dependencies
# ------------

test-xpass    : test-xpass_do
test-xpass_do : $(xpass)
$(xpass)      : $(json)


# recipes
# -------

$(xpass) :\
T_xpass_%: %
	@$(call test,$<) >$(testoutTo)

test-xpass:; @echo 'tests done (n=$(words $(xpass)))'


# ------------------------------------------------------------- #
#                           functions                           #
# ------------------------------------------------------------- #

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
else
  build       = FORCE_COLOR=0 pnpm build
  test        = FORCE_COLOR=0 $(testCmd) --compact $1|awk '! /run success/'
endif
