## Testing

When building a syntax definition, rather than manually checking scopes with the `show_scope_name` command, you can define a syntax test file that will do the checking for you:

```c
// SYNTAX TEST "Packages/C/C.sublime-syntax"
#pragma once
// <- source.c meta.preprocessor.c++
 // <- keyword.control.import

// foo
// ^ source.c comment.line
// <- punctuation.definition.comment

/* foo */
// ^ source.c comment.block
// <- punctuation.definition.comment.begin
//     ^ punctuation.definition.comment.end

#include "stdio.h"
// <- meta.preprocessor.include.c++
//       ^ meta string punctuation.definition.string.begin
//               ^ meta string punctuation.definition.string.end
int square(int x)
// <- storage.type
//  ^ meta.function entity.name.function
//         ^ storage.type
//  @@@@@@ definition
{
    printf("check %d\n", x);
//  @@@@@@ reference

    return x * x;
//  ^^^^^^ keyword.control
}

"Hello, World! // not a comment";
// ^ string.quoted.double
//                  ^ string.quoted.double - comment
```

```java
// SYNTAX TEST partial-symbols "Packages/Java/Java.sublime-syntax"

switch (foo) {
//     ^^^^^ meta.statement.conditional.switch.java meta.group.java
//      ^^^ variable.other.java

  case bar:
//     @@@ local-definition "case bar"
```

To make one, follow these rules:

- Ensure the file name starts with `syntax_test_`.
- Ensure the file is saved somewhere within the Packages directory: next to the corresponding `.sublime-syntax` file is a good choice.
- Ensure the first line of the file starts with: `<comment_token> SYNTAX TEST "<syntax_file>"`. Note that the syntax file can either be a `.sublime-syntax` or `.tmLanguage` file.

Once the above conditions are met, running the `build` command with a syntax test or syntax definition file selected will run all the Syntax Tests, and show the results in an output panel. *Next Result* (**F4**) can be used to navigate to the first failing test.

Each test in the syntax test file must first start the comment token (established on the first line, it doesn't actually have to be a comment according to the syntax), and then either a `^`, `<-` or `@` token.

The three types of tests are:

- Caret: `^` this will test the following selector against the scope on the most recent non-test line. It will test it at the same column the `^` is in. Consecutive `^`s will test each column against the selector.
- Arrow: `<-` this will test the following selector against the scope on the most recent non-test line. It will test it at the same column as the comment character is in.
- At: `@` this will test the following symbol type against the text on the most recent non-test line. The symbol type must be one of the following:
    - `none`: The text is not a symbol
    - `local-definition`: The text is the definition of a symbol but not indexed
    - `global-definition`: The text is the definition of a symbol that is indexed
    - `definition`: The text is the definition of a symbol, indexed or not
    - `reference`: The text is a reference to a symbol

When one of these tests is present all symbols in the file are checked exhaustively. This can be disabled with the `partial-symbols` options.

Symbols that are transformed by a `symbolTransformation` setting can be tested for by specifying the result of the transformation in quotes.

Test options may be specified directly after `SYNTAX TEST` separated by spaces and can be any of the following:

- `partial-symbols`: Normally when a symbol test (`@`) is present all symbols in the file are required to be checked. This option disables that behavior.
- `reindent-unchanged`: Take the whole file as a test for indentation rules. Check that when the reindent command is run on the whole file that no line is changed.
- `reindent-unindented`: Take the whole file as a test for indentation rules. Check that if all lines were unindented that the reindent command reproduces the file.
- `reindent`: Both `reindent-unchanged` and `reindent-unintented`.
