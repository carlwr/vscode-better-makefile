# SYNTAX TEST "source.makefile"


define name

STRING
#^^^^^                string.unquoted.makefile
#<-                   string.unquoted.makefile
#^^^^^                meta.string.makefile
#<-                   meta.string.makefile

 space-indented
#^^^^^^^^^^^^^^       string.unquoted.makefile
#^^^^^^^^^^^^^^       meta.string.makefile


	_TAB_-indented
#^^^^^^^^^^^^^^       string.unquoted.makefile
#^^^^^^^^^^^^^^       meta.string.makefile
#^^^^^^^^^^^^^^     - meta.scope.recipe.makefile
#<-                 - meta.scope.recipe.makefile
#
# NOTE: the above is not a recipe, it is (at this point at least) only a string who's first char is a tab

endef
