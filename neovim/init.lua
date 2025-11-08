vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = ","
vim.o.cursorline = true

vim.keymap.set("n", "<leader>h", ":noh<CR>", { desc = "Clear highlight" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim" },
    { 'nvim-telescope/telescope.nvim' },
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "javascript" },
    highlight = { enable = true },
})

require('telescope').setup {
    defaults = {
        hidden = true,
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = true,
        }
    }
}

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})

require("lualine").setup({
    options = {
        theme = "auto",
        section_separators = "",
        component_separators = ""
    },
})

vim.cmd.colorscheme("tokyonight")
