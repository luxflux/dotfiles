call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'srcery-colors/srcery-vim'

Plug 'sheerun/vim-polyglot'     " all the languages
Plug 'wincent/terminus'         " switch cursor for insert/normal mode
Plug 'ervandew/supertab'        " use tab for completion
Plug 'airblade/vim-gitgutter'   " show changes on line in the gutter
Plug 'vim-scripts/trailing-whitespace' " fix whitespaces

Plug '/usr/local/opt/fzf'       " basic fzf integration
Plug 'junegunn/fzf.vim'         " advanced fzf integration
Plug 'godlygeek/tabular'        " table helpers
Plug 'kassio/neoterm'           " easier terminal management (ctrl-w and stuff)
Plug 'neomake/neomake'          " async stuff
Plug 'tpope/vim-commentary'     " Use gcc to comment a line
Plug 'tpope/vim-fugitive'       " Gblame and friends
Plug 'sbdchd/neoformat'         " formatting for all the different file types
Plug 'jaawerth/neomake-local-eslint-first'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

" Directories
silent !mkdir -p ~/.config/nvim/_backup ~/.config/nvim/_temp ~/.config/nvim/_undo
set backupdir=~/.config/nvim/_backup    " where to put backup files
set directory=~/.config/nvim/_temp      " where to put swap files
set undodir=~/.config/nvim/_undo        " where to save undo histories

" Colors
set termguicolors
let g:srcery_italic = 1
let g:srcery_bold = 1
let g:srcery_underline = 1
let g:srcery_undercurl = 1
let g:srcery_inverse = 1
let g:srcery_inverse_matches = 1
let g:srcery_inverse_match_paren = 1
let g:solarized_visibility = 'high'

function! SetBackgroundMode(...)
  let s:iterm_profile = $ITERM_PROFILE
  let s:mode = systemlist("osascript -e 'tell application \"System Events\" to tell appearance preferences to return (get dark mode)'")[0]
  if s:mode == "false"
    set background=light
    colorscheme solarized
  else
    set background=dark
    colorscheme srcery
  endif
endfunction
call SetBackgroundMode()

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
autocmd FileType c,cpp,java,php,ruby,python,javascript,scala,elixir,markdown,scss,eruby,javascriptreact autocmd BufWritePre * :FixWhitespace

""""""""""""""""""""""""""""""
" tabular
""""""""""""""""""""""""""""""
vmap ,t :Tabularize /\|/<CR>

""""""""""""""""""""""""""""""
" linting and so
""""""""""""""""""""""""""""""
" run neomake after every write
autocmd BufWritePost * Neomake

""""""""""""""""""""""""""""""
" Testing
""""""""""""""""""""""""""""""
autocmd FileType ruby nnoremap <buffer> ,t :below T rspec %:<c-r>=line('.')<cr><cr>
autocmd FileType javascript nnoremap <buffer> ,t :below T yarn run test %<cr><cr>
autocmd FileType javascript nnoremap <buffer> ,W :below T yarn run test:watch %<cr><cr>

""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""
let g:neoterm_size = 20
" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert
" allow using ctrl-w to switch out of the terminal
tnoremap <C-w> <C-\><C-n><C-w>

""""""""""""""""""""""""""""""
" Code formatting
""""""""""""""""""""""""""""""
map ,p :Neoformat<CR>
let g:neoformat_xml_tidy = {
            \ 'exe': 'tidy',
            \ 'args': ['-quiet',
            \          '-xml',
            \          '--indent auto',
            \          '--indent-spaces ' . shiftwidth(),
            \          '--vertical-space yes',
            \          '--tidy-mark no',
            \          '--wrap -1'
            \         ],
            \ 'stdin': 1,
            \ }

let g:neoformat_javascriptreact_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--stdin-filepath', '"%:p"'],
        \ 'stdin': 1,
        \ }
let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']

""""""""""""""""""""""""""""""
" Max n chars per line
""""""""""""""""""""""""""""""
autocmd FileType ruby setlocal colorcolumn=111
autocmd FileType javascript setlocal colorcolumn=101
autocmd FileType javascriptreact setlocal colorcolumn=101

""""""""""""""""""""""""""""""
" Spellchecking
""""""""""""""""""""""""""""""
set spell

""""""""""""""""""""""""""""""
" Autolinking
""""""""""""""""""""""""""""""
function StoryIdentifier()		
  let current_branch = system("git rev-parse --abbrev-ref HEAD")		
  let ref = substitute(current_branch, '^\(\w\+\)-\(\d\+\).\+$', '\1-\2', '')		
  return ref
endfunction		
iab STORY <C-R>=StoryIdentifier()<CR>

""""""""""""""""""""""""""""""
" Gutentags
""""""""""""""""""""""""""""""
set statusline+=%{gutentags#statusline()}
let g:gutentags_exclude_filetypes=['gitcommit']
let g:gutentags_ctags_exclude = ['node_modules', 'tmp', 'public', 'vendor', 'coverage']
