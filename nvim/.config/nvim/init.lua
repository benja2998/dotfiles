vim.loader.enable()

if vim.fn.has("nvim-0.12") == 0 then
	error("Version is too old!")
end

vim.o.termguicolors = true
vim.o.timeoutlen = 250
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/nvim-mini/mini.icons' },
	{ src = 'https://github.com/ibhagwan/fzf-lua' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/benja2998/vim-tmux-navigator' }, -- Lua fork of vim-tmux-navigator
})

require'mini.icons'.setup()

require'nvim-treesitter'.setup {
	install_dir = vim.fn.stdpath('data') .. '/site'
}

require'nvim-treesitter'.install {
	'rust', 'c', 'cpp', 'asm', 'make', 'cmake', 'python', 'javascript', 'typescript', 'zig', 'lua', 'markdown', 'bash', 'zsh', 'gitcommit', 'gitignore', 'readline', 'tmux', 'vim', 'vimdoc', 'rasi', 'nix', 'perl', 'objc', 'json', 'yaml', 'toml', 'xml', 'hcl', 'dockerfile', 'nginx', 'git_config', 'kitty', 'go', 'ruby', 'r', 'java', 'kotlin', 'scala', 'sql', 'php', 'graphql', 'vue', 'css', 'scss', 'svelte', 'html', 'http', 'clojure', 'c_sharp', 'elixir', 'erlang', 'fish', 'fortran', 'julia', 'matlab', 'd', 'dart', 'fsharp', 'ledger', 'nim', 'pascal', 'prisma', 'racket', 'tsx', 'vala', 'wgsl', 'beancount', 'bibtex', 'dhall', 'dot', 'fennel', 'godot_resource', 'hjson', 'jq', 'kdl', 'llvm', 'meson', 'proto', 'twig', 'yang'
}

vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'

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

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>t', function() vim.fn.system('tmux split-window -v') end)
vim.keymap.set('v', '<leader>y', '\"+y', { silent = true })
vim.keymap.set('n', '<leader>d', function() vim.diagnostic.setqflist({ open = false }) end)
vim.keymap.set('n', '<leader>p', '\"+p', { silent = true })
vim.keymap.set('n', '<leader>w', ':write<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { silent = true })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', 'H', ':tabprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', function() require("oil").toggle_float() end)
vim.keymap.set('n', '<leader>gf', ':FzfLua git_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>bf', ':FzfLua buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', { silent = true })
vim.keymap.set('n', '<leader>of', ':FzfLua oldfiles<CR>', { silent = true })
vim.keymap.set('n', '<leader>qf', ':FzfLua quickfix<CR>', { silent = true })
vim.keymap.set('n', '<leader>lf', ':FzfLua live_grep<CR>', { silent = true })

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
vim.api.nvim_set_hl(0, "TabLine", { fg = colors.mauve, bg = colors.mantle })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.mauve, bg = colors.mantle, underline = true })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = colors.mauve, bg = colors.mantle })
