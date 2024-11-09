-- Neovim Configuration File

-- General Settings
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.mouse = 'a'                  -- Enable mouse support
vim.opt.ignorecase = true           -- Case insensitive search
vim.opt.smartcase = true            -- Case sensitive if uppercase present
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.incsearch = true            -- Incremental search
vim.opt.hidden = true               -- Allow switching buffers without saving
vim.opt.cursorline = true           -- Highlight current line
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 2              -- Size of indent
vim.opt.tabstop = 2                 -- Number of spaces tabs count for
vim.opt.softtabstop = 2             -- Number of spaces for soft tabs
vim.opt.autoindent = true           -- Copy indent from current line when starting new line
vim.opt.smartindent = true          -- Smart autoindenting when starting a new line
vim.opt.wrap = false                -- Don't wrap lines
vim.opt.backup = false              -- Don't create backup files
vim.opt.writebackup = false         -- Don't create backup files during write
vim.opt.swapfile = false            -- Don't create swap files
vim.opt.undofile = true             -- Enable persistent undo
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir') -- Set undo directory
vim.opt.termguicolors = true        -- Enable true color support
vim.opt.scrolloff = 8               -- Minimum number of screen lines above and below cursor
vim.opt.sidescrolloff = 8           -- Minimum number of screen columns to keep to the left and right of cursor
vim.opt.signcolumn = 'yes'          -- Always show sign column
vim.opt.colorcolumn = '80'          -- Show column guide at 80 characters
vim.opt.updatetime = 50             -- Faster completion
vim.opt.timeoutlen = 300            -- Time to wait for mapped sequence to complete
vim.opt.clipboard = 'unnamedplus'    -- Use system clipboard
vim.opt.completeopt = 'menuone,noselect' -- Better completion experience
vim.g.mapleader = ' '               -- Set leader key to space

-- Install Packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Plugin Management with Packer
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Theme
  use 'dracula/vim'
  
  -- File Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons'
  }
  
  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- LSP Support
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }
  
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  }
  
  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive'
  }
  
  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  
  -- Auto pairs
  use 'windwp/nvim-autopairs'
  
  -- Comments
  use 'numToStr/Comment.nvim'
  
  -- Which key
  use 'folke/which-key.nvim'
end)

-- Plugin Configurations

-- Theme
vim.cmd[[colorscheme dracula]]

-- Nvim Tree
require('nvim-tree').setup{}
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files)
vim.keymap.set('n', '<leader>fg', telescope.live_grep)
vim.keymap.set('n', '<leader>fb', telescope.buffers)
vim.keymap.set('n', '<leader>fh', telescope.help_tags)

-- LSP Configuration
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'pyright', 'tsserver', 'rust_analyzer' }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP Keybindings
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- Autocompletion
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' }
  }
})

-- Gitsigns
require('gitsigns').setup()

-- Lualine
require('lualine').setup{
  options = {
    theme = 'dracula'
  }
}

-- Treesitter
require('nvim-treesitter.configs').setup{
  ensure_installed = { "lua", "vim", "python", "javascript", "typescript", "rust" },
  highlight = {
    enable = true
  }
}

-- Autopairs
require('nvim-autopairs').setup{}

-- Comments
require('Comment').setup()

-- Which Key
require('which-key').setup{}

-- Additional Key Mappings
vim.keymap.set('n', '<leader>w', ':w<CR>')           -- Save
vim.keymap.set('n', '<leader>q', ':q<CR>')           -- Quit
vim.keymap.set('n', '<C-h>', '<C-w>h')               -- Window navigation
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')  -- Clear search highlighting

-- Create autocommands
local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({timeout = 300})
  end
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  callback = function()
    vim.lsp.buf.format()
  end
})

