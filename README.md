package originally generated with: `npx --package yo --package generator-code -- yo code`


non-compact json:
```shell
$ mv syntaxes/make.tmLanguage.json{,.bak}
syntaxes/make.tmLanguage.json -> syntaxes/make.tmLanguage.json.bak
$ jq <syntaxes/make.tmLanguage.json.bak >syntaxes/make.tmLanguage.json
```



tmLanguage.json based on:
```
/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/extensions/make/syntaxes/make.tmLanguage.json
```


# scope names

* built-in variables (= special variables)
  * `variable.language`
  * user may read, not set
    * e.g. `MAKEFLAGS`
    * `variable.other.constant`, since an immutable variable
    * `variable.language.constant`, since immutable variables should get scope `variable.[*.]constant`
  * user may read and set
    * e.g. `CURDIR`
    * `variable.language.readwrite`
  * ref's
    * https://www.sublimetext.com/docs/scope_naming.html#variable