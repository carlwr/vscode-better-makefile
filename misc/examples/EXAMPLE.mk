SHELL          :=  /bin/bash
.DEFAULT_GOAL  :=  prog

DOCS           :=  ./docs
ref-md         :=  $(wildcard ref_*.md)
ref-tex        :=  $(ref-md:%.md=%.tex)
hdir           :=  ./headers

ifdef VERBOSE
  bash-v ::= $(shell echo $$BASH_VERSION)
  $(info make $(MAKE_VERSION), bash $(bash-v))
endif

.PHONY: docs clean

# docs
# ----

docs: $(DOCS)/doc.pdf .WAIT \
      $(DOCS)/ref.pdf

$(DOCS)/%.pdf: %.tex
	mkdir -p $(@D) && pandoc -o $@ -- $<

$(DOCS)/ref.pdf: $(ref-tex)
	pandoc -o $@ -- $^

%.tex: %.md
	pandoc -M date=$(shell date +%F) -o $@ -- $<

dbg-md :; @echo '#ref-md  $(words $(ref-md))'
dbg-tex:; @echo '#ref-tex $(words $(ref-tex))'

# binary
# ------

defines:; @gcc $(CFLAGS) -dM -E - </dev/null
# ^ make.tmbundle starts a never-ending `define`
# ...highlighting of rest of the file is broken

prog: prog.o calc.o
	gcc -o $@ $^

%.o: %.c
	gcc $(CFLAGS) -I$(hdir) -c -o $@ $<

prog.o: $(hdir)/prog.h \
        $(hdir)/extra.h

calc.o: CFLAGS += -O2

clean:
	@-rm -f prog *.o $(ref-tex) $(DOCS)/*.pdf
