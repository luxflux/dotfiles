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

  -- Language Support
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'Shougo/ddc.vim'
  use 'vim-denops/denops.vim'
  use 'tani/ddc-git'
  use 'matsui54/ddc-buffer'
  use 'delphinus/ddc-treesitter'
  use 'Shougo/ddc-nvim-lsp'
  use 'Shougo/ddc-matcher_head'
  use 'Shougo/ddc-sorter_rank'

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
  fn['ddc#custom#patch_global']('sources', {'nvim-lsp', 'treesitter', 'buffer', 'git-branch'})
  fn['ddc#custom#patch_global']('completionMode', 'inline')
  fn['ddc#custom#patch_global']('sourceOptions', { _ = { matchers = {'matcher_head'}}})
  fn['ddc#custom#patch_global']('sourceOptions', { _ = { sorters = {'sorter_rank'}}})
  fn['ddc#custom#patch_global']('sourceOptions', { ['nvim-lsp'] = { mark = '[LSP]' }})
  fn['ddc#custom#patch_global']('sourceOptions', { ['treesitter'] = { mark = '[TS]' }})
  fn['ddc#custom#patch_global']('sourceOptions', { ['git-branch'] = { mark = '[GB]' }})
  fn['ddc#custom#patch_global']('sourceOptions', { ['buffer'] = { mark = '[B]' }})
  fn['ddc#custom#patch_global']('sourceParams', { ['buffer'] = {
    requireSameFiletype = false,
    fromAltBuf = true,
    forceCollect = true,
    bufNameStyle = 'basename',
  }})

  map('i', '<TAB>', "ddc#map#pum_visible() ? '<C-n>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<TAB>' : ddc#map#manual_complete()", {expr = true})
  map('i', '<S-TAB>', "ddc#map#pum_visible() ? '<C-p>' : '<C-h>'")
  fn['ddc#enable']()

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
  cmd 'autocmd BufReadPost *.jbuilder set ft=ruby'

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
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    }
  }

  -- LSP
  local lsp = require 'lspconfig'
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end
  lsp.solargraph.setup{
    on_attach = on_attach,
  }

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
