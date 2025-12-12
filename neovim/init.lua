-- [[ Options ]] --
vim.o.number = true -- Show line numbers
vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h14"
vim.o.relativenumber = true -- Relative line numbers
vim.o.termguicolors = true -- Enable 24-bit color
vim.o.tabstop = 4 -- 4 space tabs
vim.o.shiftwidth = 4 -- 4 space tabs
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.cursorline = true -- Highlight current line
vim.o.smartindent = true -- Smart indentation

-- [[ Leader key ]] --
vim.g.mapleader = ' ' -- Space

-- [[ Netrw ]] --
vim.g.netrw_banner = 0 -- No banner
vim.g.netrw_liststyle = 1 -- Long listing style
vim.g.netrw_keepdir = 0 -- Change Neovim directory when entering a directory

-- [[ Lazy.nvim bootstrap ]] --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Packages ]] --
require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "neovim/nvim-lspconfig", name = "nvim-lspconfig" },
    { "mason-org/mason.nvim", name = "mason", opts = {} },
    { "mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },
})

-- [[ Catppuccin setup ]] --
require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme("catppuccin-mocha")

-- [[ LSP setup ]] --
require("mason").setup()
require("mason-lspconfig").setup({
    handlers = {
        function(server)
            vim.lsp.config(server)
            vim.lsp.setup(server)
        end,
    },
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        -- Go to
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- Hover / info
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Code actions / rename
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, opts)
    end,
})

-- [[ nvim-cmp setup ]] --
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

-- [[ Keymaps ]] --
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
vim.keymap.set('n', '<leader>m', ':Mason<CR>', { silent = true})
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { silent = true})
vim.keymap.set('n', '<leader>o', ':copen<CR>', { silent = true})
-- Mimic the terminal function of IDEs like VS Code
vim.keymap.set("n", "<leader>t", function()
    local dir = vim.fn.expand("%:p:h")
    vim.cmd("lcd " .. dir)
    vim.cmd("bot10split | terminal")
end)
