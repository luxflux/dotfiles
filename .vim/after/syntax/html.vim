" fix javascript templates
unlet b:current_syntax
syn include @HTML $VIMRUNTIME/syntax/html.vim
syn region htmlTemplate start=+<script [^>]*type *=[^>]*text/ng-template[^>]*>+ end=+</script>+me=s-1 keepend contains=@HTML,htmlScriptTag,@htmlPreproc
