vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.number = true

vim.pack.add({
    'https://github.com/benja2998/eel.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/folke/tokyonight.nvim',
})

vim.cmd[[colorscheme tokyonight]]

require('lualine').setup()

local eel = require("eel")
eel.add_CX_key("d", "<CMD>Lex<CR>")
eel.add_key("u", "<C-o><C-r>")
