set nocompatible                " be iMproved
filetype off                    " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" color themes
Bundle 'chriskempson/vim-tomorrow-theme'

"" languages
Bundle 'vim-ruby/vim-ruby'
Bundle 'bling/vim-airline'
Bundle 'cespare/vim-toml'
Bundle 'chriseppstein/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
"Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-cucumber'
Bundle 'groenewege/vim-less'
Bundle 'netdata/vim-puppet'
Bundle 'wting/rust.vim'
Bundle 'elixir-lang/vim-elixir'

"" Tools
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
"Bundle 'luxflux/vim-git-inline-diff'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-surround'
Bundle 'docunext/closetag.vim'
Bundle 'jamessan/vim-gnupg'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'bufkill.vim'
Bundle 'trailing-whitespace'
Bundle 'xolox/vim-misc'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'christoomey/vim-tmux-navigator'

""" testing
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-dispatch'

""""""""""""""""""""""""""""""
"  configuration
""""""""""""""""""""""""""""""

color Tomorrow-Night-Eighties

syntax enable
set encoding=utf-8
filetype plugin indent on

set number
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands
set shell=bash  " avoids munging PATH under zsh
let g:is_bash=1

set guifont=Source_Code_Pro_for_Powerline:h14,Source_Code_Pro_for_Powerline:h12

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

" syntastic
let g:syntastic_warning_symbol='⚠'
let g:syntastic_error_symbol='✗'
let g:syntastic_auto_loc_list=1

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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

" set indenting for puppet files
autocmd FileType puppet setlocal shiftwidth=4 tabstop=4

" fancy powerline symbols
let g:airline_powerline_fonts = 1
" enable status line
set laststatus=2
" enable airline tabline
let g:airline#extensions#tabline#enabled = 1

" ctrlp configuration
"nnoremap <silent> <D-P> :ClearCtrlPCache<cr>
nnoremap <silent> P :ClearCtrlPCache<cr>
let g:ctrlp_custom_ignore = '\v[\/]coverage$'

" vim-rspec configuration
"nmap <silent> <D-R> :call RunCurrentSpecFile()<CR>
"nmap <silent> <D-L> :call RunNearestSpec()<CR>
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
let g:rspec_command = "Dispatch rspec {spec}"

" completion configuration
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_comments = 1

" git gutter plugin
let g:gitgutter_sign_added = '⇒'
let g:gitgutter_sign_modified = '⇔'
let g:gitgutter_sign_removed = '⇐'
let g:gitgutter_sign_modified_removed = '⇐'

" completion
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=coverage/**
set wildignore+=*.png,*.jpg,*.gif

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

" tagbar configuration
"autocmd VimEnter * TagbarToggle

if has("autocmd")

  function s:setupWrapping()
    set wrap
    set wrapmargin=2
    set textwidth=80
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
endif

" get reference for the current commit from git flow
function GitRedmineIssue(fixes)
  let current_branch = system("git rev-parse --abbrev-ref HEAD")
  let ref = substitute(current_branch, '^.\+\/\(\d\+\).\+$', '\1', '')
  if a:fixes == 'true'
    let prefix = 'fixes'
  else
    let prefix = 'refs'
  endif
  return prefix . ' #' . ref
endfunction
iab REFS <C-R>=GitRedmineIssue('false')<CR>
iab FIXES <C-R>=GitRedmineIssue('true')<CR>

" fix whitespaces before writing the buffer
autocmd BufWritePre * :FixWhitespace

" enable line wrapping in the quickfix window
autocmd FileType qf setlocal wrap linebreak

" allow copying to tmux buffer
set clipboard=unnamed
