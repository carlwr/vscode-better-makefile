import * as cfg from './cfg.js';
import * as validateLogic from './tmgrammar-validate.js';

export async function validate() {
  await validateLogic.validateGrammar(
    cfg.GRAMMAR_JSON,
    cfg.SCOPE_NAME,
    SAMPLE_SNIPPETS
  )
}

const SAMPLE_SNIPPETS = [
  "all: t1 t2",
  "t: p1 p2\n\tcmd1\n\tcmd2",
  "# cmt",
  "u = a",
  "v := b",
  "blah",
  "export w = e",
  "ifeq ($(V),v)\nall: t\nelse\nall: u\nendif",
  "define W\nc\nd\nendef",
  "%.o: %.c\n\t$(CC) -o $@ $<",
  "X = $(shell uname)",
  "Y = $(call f,a)",
  "Z = $(if $(c),A,B)",
];
