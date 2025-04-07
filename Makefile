.SHELLFLAGS +=  -eu -o pipefail
MAKEFLAGS   +=  --no-builtin-rules          \
                --warn-undefined-variables  \
                --jobs 6                    \
                --output-sync

HUMAN   ?=

json    :=  syntaxes/makefile.tmLanguage.json
yaml    :=       src/makefile.tmLanguage.yaml


# ------------------------------------------------------------- #
#                          rules: main                          #
# ------------------------------------------------------------- #

.PHONY:         \
  build         \
  clean         \
  inspect.%


# dependencies
# ------------

build    : $(json)
$(json)  : $(yaml)


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
#                           functions                           #
# ------------------------------------------------------------- #

ifdef HUMAN
  build       = FORCE_COLOR=3 pnpm build
else
  build       = FORCE_COLOR=0 pnpm build
endif
