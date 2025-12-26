-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "stevearc/oil.nvim",
    "neovim/nvim-lspconfig",
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc" },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
})

vim.cmd("colorscheme catppuccin-mocha")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.background = "dark" -- default to dark or light style

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.shortmess:append("I")
vim.opt.laststatus = 3

require("oil").setup({
    view_options = {
        show_hidden = true,   -- show dotfiles by default
        is_hidden_file = function(name, _)
            return name:match("^%..*") ~= nil
        end,
        is_always_hidden = function(name, _)
            return false
        end,
    },
})

-- Set space as the leader key
vim.g.mapleader = " "

vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], { silent = true })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':bdelete!<CR>', { silent = true })
vim.keymap.set('n', '<leader>n', ':enew<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { silent = true })
vim.keymap.set('n', 'H', ':bprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':bnext<CR>', { silent = true })
vim.keymap.set('n', 'q:', '<nop>', { silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>gf', ':Telescope git_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>gl', ':Telescope live_grep<CR>', { silent = true })
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { silent = true })
vim.keymap.set('n', '<leader>m', ':Mason<CR>', { silent = true })

require('lualine').setup()
require('bufferline').setup()
