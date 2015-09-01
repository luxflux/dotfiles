set nocompatible                " be iMproved

call plug#begin('~/.vim/plugged')

" color themes
Plug 'tomasr/molokai'

"" languages
Plug 'vim-ruby/vim-ruby'
Plug 'cespare/vim-toml'
Plug 'chriseppstein/vim-haml'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-cucumber'
Plug 'groenewege/vim-less'
Plug 'netdata/vim-puppet'
Plug 'tpope/vim-liquid'
Plug 'fatih/vim-go'
Plug 'mtscout6/vim-cjsx'

"" Tools
Plug 'bling/vim-airline'
Plug 'benekastah/neomake'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'docunext/closetag.vim'
Plug 'jamessan/vim-gnupg'
Plug 'trailing-whitespace'
Plug 'ervandew/supertab'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'kassio/neoterm'
Plug 'thoughtbot/vim-rspec'

call plug#end()

""""""""""""""""""""""""""""""
"  configuration
""""""""""""""""""""""""""""""

let g:rehash256 = 1
color molokai

syntax enable
set encoding=utf-8
filetype plugin indent on

set number
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands

set guifont=Source_Code_Pro_for_Powerline:h16,Source_Code_Pro_for_Powerline:h16

set autoread
set history=1000

if has("gui_macvim")
  set noballooneval
endif

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the first column when wrap is
" off and the line continues beyond the left of the screen
"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" provide some context when editing
set scrolloff=3

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

silent !mkdir -p ~/.vim/_backup ~/.vim/_temp ~/.vim/_undo
set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.
set undodir=~/.vim/_undo     " where to save undo histories

" undo history
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" paste mode toggle
map <F4> :set invpaste<CR>

" toggle number
nmap <F5> :set number! number?<CR>

" fancy powerline symbols
let g:airline_powerline_fonts = 1
" enable status line
set laststatus=2
" enable airline tabline
let g:airline#extensions#tabline#enabled = 1
" airline theme
let g:airline_theme='simple'

nnoremap <C-P> :FZF<cr>

" vim-rspec configuration
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
let g:rspec_command = "T rspec {spec}"

" git gutter plugin
let g:gitgutter_sign_added = '⇒'
let g:gitgutter_sign_modified = '⇔'
let g:gitgutter_sign_removed = '⇐'
let g:gitgutter_sign_modified_removed = '⇐'

" Tab on the command line will show a menu to complete buffer and file names
set wildchar=<Tab> wildmenu wildmode=full
" select buffer
nnoremap <Tab><Tab> :b <Tab>
set wildcharm=<Tab>

" surrounding
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

" Switch to specific tab numbers with Command-number
noremap <D-1> :buffer 1<CR>
noremap <D-2> :buffer 2<CR>
noremap <D-3> :buffer 3<CR>
noremap <D-4> :buffer 4<CR>
noremap <D-5> :buffer 5<CR>
noremap <D-6> :buffer 6<CR>
noremap <D-7> :buffer 7<CR>
noremap <D-8> :buffer 8<CR>
noremap <D-9> :buffer 9<CR>

if has("autocmd")

  function s:setupWrapping()
    set wrap
    set wrapmargin=2
    set textwidth=110
  endfunction

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif

  " eyaml is yaml
  au BufNewFile,BufRead *.eyaml setlocal ft=yaml

  " fix whitespaces before writing the buffer
  au BufWritePre * :FixWhitespace

  " enable line wrapping in the quickfix window
  au FileType qf setlocal wrap linebreak

  " run neomake after save
  au BufWritePost * Neomake

  " run ctags after save
  au BufWritePost * Neomake! ctags
endif

" get reference for the current commit from git flow
function GitRedmineIssue(fixes)
  let current_branch = system("git rev-parse --abbrev-ref HEAD")
  let ref = substitute(current_branch, '^\(\d\+\).\+$', '\1', '')
  if a:fixes == 'true'
    let prefix = 'fixes'
  else
    let prefix = 'refs'
  endif
  return prefix . ' #' . ref
endfunction
iab REFS <C-R>=GitRedmineIssue('false')<CR>
iab FIXES <C-R>=GitRedmineIssue('true')<CR>

set clipboard+=unnamedplus

hi Normal     ctermbg=none
hi SignColumn ctermbg=none
hi LineNr     ctermbg=none

set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=1 " Don't render italic, bold, links in HTML

" color over 100 signs
set colorcolumn=111
hi ColorColumn term=reverse cterm=bold ctermfg=233 ctermbg=208 gui=bold guifg=#000000 guibg=#FD971F

" disable folding
set nofoldenable

" faster vim startup
let g:ruby_path = system('echo $BOXEN_HOME/rbenv/shims')

tnoremap <Esc> <C-\><C-n>

let g:neomake_ctags_maker = {
      \ 'exe': 'ctags',
      \ 'args': [
        \ '-a',
        \ '-f .git/tags',
        \ '--tag-relative',
        \ '--exclude=.git',
        \ '--exclude=tmp',
        \ '--exclude=coverage',
        \ '--languages=-javascript,sql',
        \ '%p']
  \ }

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
