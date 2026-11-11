ifeq ($(filter notintermediate,$(.FEATURES)),)
  $(error requires GNU make 4.4+; running: $(MAKE) $(MAKE_VERSION))
endif
  # use the "notintermediate" as a proxy; it entered GNU make at v4.4

SHELL        :=  bash
.SHELLFLAGS  +=  -eu -o pipefail
MAKEFLAGS    +=  --no-builtin-rules          \
                 --warn-undefined-variables  \
                 --jobs 6                    \
                 --output-sync

NO_COLOR     ?=
MAKE_TERMOUT ?=

json         := makefile.tmLanguage.json
scopes       := makefile.scopes.txt

outs         :=  syntaxes/$(json)  syntaxes/$(scopes)
outs-checks  := out/check/$(json) out/check/$(scopes)

runner       := test/runner/Makefile
tsx          := node_modules/.bin/tsx

diff-jsons   := diff -u syntaxes/$(json)   out/check/$(json)
diff-scopes  := diff -u syntaxes/$(scopes) out/check/$(scopes)

color        := $(if $(NO_COLOR),,$(MAKE_TERMOUT))
FORCE_COLOR  := $(if $(color),3,0)

export FORCE_COLOR


# ------------------------------------------------------------- #
#                             rules                             #
# ------------------------------------------------------------- #

.PHONY:         \
  test          \
  clean         \
  gen           \
  check         \
  FORCE         \
  inspect.%

FORCE:

.DEFAULT_GOAL := gen


# dependencies
# ------------

gen: $(outs)

check: $(outs-checks)  # should _not_ build $(outs)

test: gen


# recipes
# -------

# build both json and scopes to any dir:
%/$(json) %/$(scopes) &: FORCE
	$(tsx) build.ts --out-dir $*
	scripts/scopes $*/$(json) >$*/$(scopes)

check:
	$(diff-scopes)
	$(diff-jsons)

clean:
	rm -rf $(outs) $(outs-checks)

test:
	@$(MAKE) -f $(runner)

inspect.%:
	@printf 'unevaluated: %s\n' '$(value $*)'
	@printf 'evaluated  : %s\n' '$($*)'
