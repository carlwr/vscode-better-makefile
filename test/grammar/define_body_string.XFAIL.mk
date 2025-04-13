# SYNTAX TEST "source.makefile"


define name

STRING
#^^^^^                string.unquoted
#<-                   string.unquoted
#^^^^^                meta.string
#<-                   meta.string

 space-indented
#^^^^^^^^^^^^^^       string.unquoted
#<-                   string.unquoted
#^^^^^^^^^^^^^^       meta.string
#<-                   meta.string


	_TAB_-indented
#^^^^^^^^^^^^^^       string.unquoted
#<-                   string.unquoted
#^^^^^^^^^^^^^^       meta.string
#<-                   meta.string
#^^^^^^^^^^^^^^     - meta.scope.recipe.makefile
#<-                 - meta.scope.recipe.makefile
#
# NOTE: the above is not a recipe, it is (at this point at least) only a string who's first char is a tab

endef
