--[[
Modern Neovim configuration for Neovim 0.12+
Uses modern APIs and stays lightweight
--]]

if vim.fn.has("nvim-0.12") == 0 then
	error("Neovim is too old! Stopping Neovim config.")
end

vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.statusline = " %f %m %r %=  %P"
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/benja2998/vim-tmux-navigator' }, -- Lua fork of vim-tmux-navigator
})

require'nvim-treesitter'.setup {
	install_dir = vim.fn.stdpath('data') .. '/site'
}

require'nvim-treesitter'.install {
	'rust',
	'javascript',
	'typescript',
	'zig',
	'lua',
	'markdown',
	'bash',
	'zsh',
	'gitcommit',
	'gitignore',
	'readline',
	'tmux',
	'vim',
	'vimdoc',
}

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf, nil)
	end,
})

vim.cmd("colorscheme catppuccin")

require("oil").setup({
	view_options = {
		show_hidden = true,
	}
})

local builtin = require('telescope.builtin')
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>t', function() vim.fn.system('tmux split-window -v') end, { silent = true })
vim.keymap.set('v', '<leader>y', '\"+y', { silent = true })
vim.keymap.set('v', '<leader>d', '\"+d', { silent = true })
vim.keymap.set('n', '<leader>p', '\"+p', { silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>&', ':tabclose<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', 'H', ':tabprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', function() require("oil").toggle_float() end, { silent = true })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { silent = true })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true })

vim.diagnostic.config({
	virtual_lines = true
})

vim.lsp.config['lua_ls'] = {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
}

pcall(vim.lsp.enable, 'lua_ls')
pcall(vim.lsp.enable, 'clangd')
pcall(vim.lsp.enable, 'pyright')
pcall(vim.lsp.enable, 'ts_ls')
pcall(vim.lsp.enable, 'rust_analyzer')

local colors = require("catppuccin.palettes").get_palette "mocha"
vim.api.nvim_set_hl(0, "StatusLine", {
	fg = colors.mauve,
	bg = colors.mantle
})
