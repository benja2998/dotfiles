vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false
vim.o.compatible = false
vim.o.laststatus = 3
vim.o.number = true
vim.o.showtabline = 0
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.background = "dark"
vim.o.mouse = "a"
vim.g.mapleader = ","
vim.cmd("syntax on")
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/RRethy/base16-nvim",
	"https://github.com/benja2998/vim-tmux-navigator",
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/tpope/vim-fugitive",
})
require("gitsigns").setup()
pcall(vim.lsp.enable, "pyright")
pcall(vim.lsp.enable, "lua_ls")
pcall(vim.lsp.enable, "clangd")
pcall(vim.lsp.enable, "ts_ls")
pcall(vim.lsp.enable, "rust-analyzer")
require"nvim-treesitter".setup {
	install_dir = vim.fn.stdpath("data") .. "/site"
}
require"nvim-treesitter".install { "perl", "ruby", "gitignore", "gitcommit", "python", "rust", "javascript", "zig", "lua", "c", "cpp", "bash", "zsh", "toml", "yaml", "fish", "tmux", "vim", "vimdoc", "make", "json", "typescript" }
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
require"oil".setup {
	view_options = {
		show_hidden = true
	}
}
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>ft", ":FzfLua tabs<CR>")
vim.keymap.set("n", "<leader>fg", ":FzfLua git_files<CR>")
vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>")
vim.keymap.set("n", "<leader>fq", ":FzfLua quickfix<CR>")
vim.keymap.set("n", "<leader>fl", ":FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end)
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>e", function() require("oil").toggle_float() end)
require("base16-colorscheme").setup({
	base00 = "#380c2a",
	base01 = "#2f0923",
	base02 = "#23071a",
	base03 = "#5e8d87",
	base04 = "#c2a2b8",
	base05 = "#ffd5f2",
	base06 = "#ffd5f2",
	base07 = "#ffd5f2",
	base08 = "#a54242",
	base09 = "#de935f",
	base0A = "#f0c674",
	base0B = "#8c9440",
	base0C = "#8abeb7",
	base0D = "#81a2be",
	base0E = "#b294bb",
	base0F = "#b294bb",
})
require"lualine".setup {
	options = {
		icons_enabled = false,
		theme = "base16",
		section_separators = { left = "█", right = "█" },
		component_separators = { left = "│", right = "│" }
	},
	tabline = {
		lualine_a = {"buffers"},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {"tabs"}
	}
}
