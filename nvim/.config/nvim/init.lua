--[[
* REQUIRES NEOVIM 0.11+
]]--

-- [[ Checks ]] --

if vim.fn.executable("fd") == 0 then
	error("'fd' executable not found! Stopping Neovim config.")
end

-- [[ Functions ]] --

function _G.fd_find_files(cmdarg, _)
	local args = {
		"fd",
		"--full-path",
		"--hidden",
		"--type", "f",
		"--exclude", ".git",
	}

	if cmdarg == "" then
		return vim.fn.systemlist(table.concat(args, " "))
	end

	table.insert(args, cmdarg)

	return vim.fn.systemlist(table.concat(args, " "))
end

-- [[ LSP ]] --

vim.lsp.config['lua_ls'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
		},
	},
}
pcall(vim.lsp.enable, 'lua_ls')

vim.lsp.config['clangd'] = {
	cmd = { 'clangd', '--background-index', '--offset-encoding=utf-8' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
}
pcall(vim.lsp.enable, 'clangd')

vim.lsp.config['pyright'] = {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}
pcall(vim.lsp.enable, 'pyright')

vim.lsp.config['ts_ls'] = {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	root_markers = { 'package.json', 'tsconfig.json', '.git' },
}
pcall(vim.lsp.enable, 'ts_ls')

vim.lsp.config['rust_analyzer'] = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', '.git' },
	settings = {
		['rust-analyzer'] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
}
pcall(vim.lsp.enable, 'rust_analyzer')

-- [[ Options ]] --

vim.opt.findfunc = "v:lua.fd_find_files"
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.scrolloff = 8
vim.opt.statusline = " %f %m %r %=  %P"
vim.opt.timeout = true
vim.opt.timeoutlen = 250

-- [[ Keymaps ]] --

vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>t', function() vim.fn.system('tmux split-window -v') end)
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>p', '\"+p')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- [[ Treesitter ]] --

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- [[ Packages ]] --

local pack_root = vim.fn.stdpath("data") .. "/site/pack"
local theme_name = "catppuccin"
local theme_path = pack_root .. "/colors/start/" .. theme_name

if vim.fn.empty(vim.fn.glob(theme_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"https://github.com/catppuccin/nvim.git",
		theme_path,
	})
end

vim.opt.runtimepath:prepend(theme_path)

local has_cat, catppuccin = pcall(require, "catppuccin")
if has_cat then
	catppuccin.setup({
		flavour = "mocha",
		transparent_background = false,
		term_colors = true,
		integrations = {
			treesitter = true,
			native_lsp = { enabled = true },
		},
	})
end

vim.cmd("colorscheme catppuccin-mocha")
