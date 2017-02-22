set nocompatible                " be iMproved

call plug#begin('~/.config/nvim/plugged')

" look&feel
" Plug 'tomasr/molokai'
Plug 'Reewr/vim-monokai-phoenix'
Plug 'ryanoasis/vim-devicons'

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
Plug 'ledger/vim-ledger'
Plug 'mxw/vim-jsx'

"" Tools
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'tpope/vim-speeddating'
Plug 'mhinz/vim-startify'

" WebUI
Plug 'rhysd/nyaovim-popup-tooltip'
Plug 'rhysd/nyaovim-markdown-preview'


call plug#end()

""""""""""""""""""""""""""""""
"  configuration
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"  colors
""""""""""""""""""""""""""""""
let g:rehash256 = 1
" color molokai
color monokai-phoenix
" set termguicolors

" airline theme
" let g:airline_theme='molokai'
let g:airline_theme='simple'

syntax enable

""""""""""""""""""""""""""""""
"  misc
""""""""""""""""""""""""""""""
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

silent !mkdir -p ~/.config/nvim/_backup ~/.config/nvim/_temp ~/.config/nvim/_undo
set backupdir=~/.config/nvim/_backup    " where to put backup files.
set directory=~/.config/nvim/_temp      " where to put swap files.
set undodir=~/.config/nvim/_undo     " where to save undo histories

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

" fix whitespaces before writing the buffer
autocmd FileType c,cpp,java,php,ruby,python,javascript,scala,elixir,markdown autocmd BufWritePre * :FixWhitespace

" run neomake after save
au BufWritePost * Neomake

" run ctags after save
au BufWritePost * Neomake! ctags

" get reference for the current commit from branch name
function JiraIssue(type)
  let current_branch = system("git rev-parse --abbrev-ref HEAD")
  let ref = substitute(current_branch, '^\(\w\+\)-\(\d\+\).\+$', '\1-\2', '')
  if a:type == 'fixes' || a:type == 'refs'
    return type . ' ' . ref
  else
    return '['. ref .'](https://welltravel.atlassian.net/browse/'. ref .')'
  endif
endfunction
iab REFS <C-R>=JiraIssue('fixes')<CR>
iab FIXES <C-R>=JiraIssue('refs')<CR>
iab STORY <C-R>=JiraIssue('story')<CR>

set clipboard+=unnamedplus

hi Normal     ctermbg=none
hi SignColumn ctermbg=none
hi LineNr     ctermbg=none

set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=1 " Don't render italic, bold, links in HTML

" color over 110 signs
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
        \ '%p']
  \ }

" js hint
let g:neomake_javascript_enabled_makers = ['eslint']

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

command! PrettyJSON :%!jq .

" ledger
let g:ledger_extra_options = '--pedantic --explicit --check-payees'
let g:ledger_commodity_sep = ' '
let g:ledger_default_commodity = 'CHF'
"
" run ledger after save
" au BufWritePost *.ledger :Ledger bal Aktiva Fremdkapital

" run ledger
autocmd FileType ledger map <buffer> ,l :Ledger bal Aktiva Fremdkapital<CR>
" align file
autocmd FileType ledger map <buffer> ,a :%LedgerAlign<CR>
" sort file
autocmd FileType ledger map <buffer> ,s :%sort<CR>
" date replacer
autocmd FileType ledger iab <expr> DATE strftime("%F")

" disable syntax highlighting for logs
au BufNewFile,BufRead *.log setlocal ft=none

" easier tabularize tables
vmap ,t :Tabularize /\|/<CR>

autocmd FileType javascript set formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma\ --print-width\ 100
autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
autocmd BufWritePre *.jsx exe "normal! gggqG\<C-o>\<C-o>"
autocmd BufNewFile,BufRead *.js set colorcolumn=101
autocmd BufNewFile,BufRead *.jsx set colorcolumn=101

" startify
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1

