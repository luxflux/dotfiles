call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'mhartington/oceanic-next'

Plug 'sheerun/vim-polyglot'     " all the languages
Plug 'wincent/terminus'         " switch cursor for insert/normal mode
Plug 'ervandew/supertab'        " use tab for completion
Plug 'airblade/vim-gitgutter'   " show changes on line in the gutter
Plug 'vim-scripts/trailing-whitespace' " fix whitespaces

Plug '/usr/local/opt/fzf'       " basic fzf integration
Plug 'junegunn/fzf.vim'         " advanced fzf integration
Plug 'godlygeek/tabular'        " table helpers
"Plug 'kassio/neoterm'           " easier terminal management
Plug 'vimlab/split-term.vim'    " easier terminal management
Plug 'neomake/neomake'          " async stuff
Plug 'tpope/vim-commentary'     " Use gcc to comment a line
Plug 'tpope/vim-fugitive'       " Gblame and friends

call plug#end()

" Directories
silent !mkdir -p ~/.config/nvim/_backup ~/.config/nvim/_temp ~/.config/nvim/_undo
set backupdir=~/.config/nvim/_backup    " where to put backup files
set directory=~/.config/nvim/_temp      " where to put swap files
set undodir=~/.config/nvim/_undo        " where to save undo histories

" Colors
set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Misc
set number
set ruler
" set cursorline " disabled for performance reasons
set showcmd
set autoread
set clipboard+=unnamedplus " system clipboard

" Whitespace
set tabstop=2     " a tab is two spaces
set shiftwidth=2  " an autoindent is two spaces
set expandtab     " use spaces, not tabs
set list          " show invisible characters

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
set inccommand=nosplit            " Substitution previews

" undo
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Tab on the command line will show a menu to complete buffer and file names
set wildchar=<Tab> wildmenu wildmode=full

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Remember last location in file, but not for commit messages.
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

" color over 110 signs on one line
set colorcolumn=111
hi ColorColumn term=reverse cterm=bold ctermfg=233 ctermbg=208 gui=bold guifg=#000000 guibg=#FD971F

""""""""""""""""""""""""""""""
" Generic Mappings
""""""""""""""""""""""""""""""
" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>


""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""
" Open FZF with CTRL+p
nnoremap <C-P> :Files<cr>
" open the buffers on tab-tab
nnoremap <Tab><Tab> :Buffers<cr>

""""""""""""""""""""""""""""""
" gitgutter
""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '⇒'
let g:gitgutter_sign_modified = '⇔'
let g:gitgutter_sign_removed = '⇐'
let g:gitgutter_sign_modified_removed = '⇐'

""""""""""""""""""""""""""""""
" whitespaces
""""""""""""""""""""""""""""""
autocmd FileType c,cpp,java,php,ruby,python,javascript,scala,elixir,markdown,scss autocmd BufWritePre * :FixWhitespace

""""""""""""""""""""""""""""""
" tabular
""""""""""""""""""""""""""""""
vmap ,t :Tabularize /\|/<CR>

""""""""""""""""""""""""""""""
" make
""""""""""""""""""""""""""""""
" run neomake after every write
autocmd BufWritePost * Neomake

""""""""""""""""""""""""""""""
" RSpec
""""""""""""""""""""""""""""""
"autocmd BufRead,BufNewFile .*_spec.rb nnoremap ,T :terminal rspec %
"nnoremap ,T :below T rspec %:<c-r>=line('.')<cr><cr>

""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""
" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert
