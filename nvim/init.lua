-- Helpers
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Install packer.nvim
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
end



-- Add plugins
return require('packer').startup(function(use)
  -- packer itself
  use 'wbthomason/packer.nvim'

  -- Remove trailing whitespaces automatically
  use 'vim-scripts/trailing-whitespace'

  -- Table helpers
  use 'godlygeek/tabular'

  -- Completion
  use 'shougo/deoplete-lsp'
  use { 'shougo/deoplete.nvim', run = fn['remote#host#UpdateRemotePlugins'] }

  -- Language Support
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'

  -- Fuzzy Finder
  use { 'junegunn/fzf', run = fn['fzf#install()'] }
  use 'junegunn/fzf.vim'

  -- Linting & Formatting
  use 'neomake/neomake'
  use 'jaawerth/neomake-local-eslint-first'
  use 'sbdchd/neoformat'

  -- comments
  use 'tpope/vim-commentary'

  -- colorscheme
  use 'srcery-colors/srcery-vim'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  -- Vertical Lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Remote Copy
  use 'justone/remotecopy-vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  -- Colors
  cmd 'colorscheme srcery'
  opt.termguicolors = true
  g['srcery_italic'] = 1
  g['srcery_bold'] = 1
  g['srcery_underline'] = 1
  g['srcery_undercurl'] = 1
  g['srcery_inverse'] = 1
  g['srcery_inverse_matches'] = 1
  g['srcery_inverse_match_paren'] = 1

  -- Completion
  g['deoplete#enable_at_startup'] = 1
  map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
  map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

  -- Misc
  opt.number = true
  opt.ruler = true
  opt.showcmd = true
  opt.autoread = true
  opt.spell = true

  -- invisible character display
  opt.list = true                           -- show invisible characters
  opt.listchars = ""                        -- Reset the listchars
  opt.listchars:append({ tab = '  ' })      -- a tab should display as "  ", trailing whitespace as "."
  opt.listchars:append({ trail = '.' })     -- show trailing spaces as dots
  opt.listchars:append({ extends = '>' })   --  The character to show in the last column when wrap is off and the line continues beyond the right of the screen
  opt.listchars:append({ precedes = '<' })  -- The character to show in the first column when wrap is off and the line continues beyond the left of the screen

  -- Whitespace
  opt.tabstop = 2      -- a tab is two spaces
  opt.shiftwidth = 2   -- an autoindent is two spaces
  opt.expandtab = true -- use spaces, not tabs

  -- Searching
  opt.hlsearch = true        -- highlight matches
  opt.incsearch = true       -- incremental searching
  opt.ignorecase = true      -- searches are case insensitive...
  opt.smartcase = true       -- ... unless they contain at least one capital letter
  opt.inccommand = 'nosplit' -- Substitution previews

  -- undo
  opt.undofile = true
  opt.undolevels = 1000  -- How many undos
  opt.undoreload = 10000 -- number of lines to save for undo

  -- Allow backgrounding buffers without writing them, and remember marks/undo
  -- for backgrounded buffers
  opt.hidden = true


  -- clear the search buffer when hitting return
  map('', '<CR>', ':nohlsearch<CR>')

  -- Max n chars per line
  cmd 'autocmd FileType ruby setlocal colorcolumn=111'
  cmd 'autocmd FileType javascript setlocal colorcolumn=101'
  cmd 'autocmd FileType javascriptreact setlocal colorcolumn=101'

  -- Jump to last position in file when reopening, but not for git messages
  cmd [[autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

  -- Treat jbuilder files as ruby files
  cmd 'autocmd BufReadPost *.jbuilder set syntax=ruby'

  -- Jira Story Linking
  vim.api.nvim_exec(
    [[
    function StoryIdentifier()
      let current_branch = system("git rev-parse --abbrev-ref HEAD")
      let ref = substitute(current_branch, '^\(\w\+\)-\(\d\+\).\+$', '\1-\2', '')
      return ref
    endfunction
    iab STORY <C-R>=StoryIdentifier()<CR>
    ]],
    false
  )

  -- Git
  require('gitsigns').setup {
    current_line_blame = false
  }

  -- Remove Whitespaces
  cmd 'autocmd FileType lua,c,cpp,java,php,ruby,python,javascript,scala,elixir,markdown,scss,eruby,javascriptreact autocmd BufWritePre * :FixWhitespace'

  -- Table helpers
  map('v', ',t', ':Tabularize /\\|/<CR>')

  -- Linting
  cmd 'autocmd BufWritePost * Neomake'

  -- Code formatting
  map('', ',p', ':Neoformat<CR>')
  g['neoformat_enabled_javascript'] = {'prettier'}
  g['neoformat_enabled_javascriptreact'] = {'prettier'}

  -- Tree-Sitter
  local ts = require 'nvim-treesitter.configs'
  ts.setup {
    ensure_installed = { "css", "dockerfile", "javascript", "json", "html", "lua", "markdown", "python", "ruby", "scss", "bash" },
    highlight = { enable = true }
  }

  -- LSP
  local lsp = require 'lspconfig'
  -- lsp.ruby.setup {}
  -- lsp.javascript.setup {}
  -- lsp.javascriptreact.setup {}

  -- FZF
  -- Open FZF with CTRL+p
  map('', '<C-P>', ':Files<CR>')
  -- open the buffers on tab-tab
  map('', '<Tab><Tab>', ':Buffers<CR>')

  -- Vertical Lines
  require('indent_blankline').setup {
    show_current_context = true,
    show_current_context_start = true,
  }

  -- Remote Copy
  map('', ',y', ':RemoteCopy<CR>')
  map('v', ',y', ':RemoteCopyVisual<CR>')

  -- Gitsigns
  require('gitsigns').setup {
    current_line_blame = true,
  }
end)
