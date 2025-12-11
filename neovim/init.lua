vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.cursorline = true
vim.g.mapleader = ','

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { silent = true })

vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "H", ":tabprevious<CR>", { silent = true })
vim.keymap.set("n", "L", ":tabnext<CR>", { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<leader>e', ':Ex<CR>', { silent = true})

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_keepdir = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
})

require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme("catppuccin-mocha")

vim.keymap.set("n", "<leader>t", function()
    local dir = vim.fn.expand("%:p:h")
    vim.cmd("lcd " .. dir)
    vim.cmd("terminal")
end)
