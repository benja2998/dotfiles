vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = ","
vim.o.cursorline = true

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", ":noh<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>c", ":tabclose<CR>")
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")
vim.keymap.set("n", "<leader>e", ":Ex %:p:h<CR>")
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>")
vim.keymap.set("n", "<Tab>", ":tabnext<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "javascript" },
  highlight = { enable = true },
})

require('telescope').setup {
  defaults = {
    hidden = true,
    mappings = {
      i = { ["<C-u>"] = false, ["<C-d>"] = false },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    }
  }
}

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = ""
  },
})

require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme("catppuccin-mocha")

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
vim.g.netrw_keepdir = 0

vim.keymap.set("n", "<leader>t", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("lcd " .. dir)
  vim.cmd("terminal")
end)
