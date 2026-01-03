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
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

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

local ts_path = vim.fn.stdpath("config") .. "pack/treesitter/start/nvim-treesitter"
if vim.fn.empty(vim.fn.glob(ts_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"--branch=master",
		"https://github.com/nvim-treesitter/nvim-treesitter.git",
		ts_path,
	})
end

vim.opt.runtimepath:prepend(ts_path)

require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"c",
		"lua",
		"python",
		"markdown",
		"bash",
		"rust"
	},
	auto_install = true,
	highlight = {
		enable = true,
	},
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

-- [[ Status Line Colors ]] --

local colors = require("catppuccin.palettes").get_palette "mocha"
vim.api.nvim_set_hl(0, "StatusLine", {
	fg = colors.mauve,
	bg = colors.mantle
})

-- [[ Tmux Integration ]] --

if vim.g.loaded_tmux_navigator or vim.fn.has("nvim-0.5") == 0 then
	return
end
vim.g.loaded_tmux_navigator = 1

local function vim_navigate(direction)
	local ok, _ = pcall(vim.cmd, "wincmd " .. direction)
	if not ok then
		vim.api.nvim_echo({{"Cannot move in direction: " .. direction, "ErrorMsg"}}, false, {})
	end
end

-- Detect if running in FZF terminal
local function is_fzf()
	return vim.bo.filetype == "fzf"
end

-- Detect tmux executable (tmux or tmate)
local function tmux_executable()
	if string.find(vim.env.TMUX or "", "tmate") then
		return "tmate"
	else
		return "tmux"
	end
end

-- Get tmux socket from $TMUX
local function tmux_socket()
	local tmux_env = vim.env.TMUX or ""
	return vim.split(tmux_env, ",")[1] or ""
end

-- Run a tmux command
local function tmux_cmd(cmd)
	local full_cmd = tmux_executable() .. " -S " .. tmux_socket() .. " " .. cmd
	return vim.fn.system(full_cmd)
end

-- Check if current tmux pane is zoomed
local function tmux_pane_zoomed()
	return tonumber(tmux_cmd("display-message -p '#{window_zoomed_flag}'")) == 1
end

-- Map Vim directions to tmux flags
local pane_dir = { h = "L", j = "D", k = "U", l = "R", p = "p" }

-- State: last tmux pane
local tmux_is_last_pane = false

-- Should forward navigation to tmux
local function should_forward(tmux_last_pane, at_tab_edge)
	if vim.g.tmux_navigator_disable_when_zoomed == 1 and tmux_pane_zoomed() then
		return false
	end
	return tmux_last_pane or at_tab_edge
end

-- Main navigation function
local function navigate(direction)
	local nr = vim.fn.winnr()
	local tmux_last_pane = (direction == "p" and tmux_is_last_pane)

	if not tmux_last_pane then
		vim_navigate(direction)
	end

	local at_tab_edge = (nr == vim.fn.winnr())

	if should_forward(tmux_last_pane, at_tab_edge) then
		-- Save buffers if requested
		if vim.g.tmux_navigator_save_on_switch == 1 then
			pcall(vim.cmd, "update")
		elseif vim.g.tmux_navigator_save_on_switch == 2 then
			pcall(vim.cmd, "wall")
		end

		local args = "select-pane -t " .. vim.fn.shellescape(vim.env.TMUX_PANE) .. " -" .. pane_dir[direction]

		if vim.g.tmux_navigator_preserve_zoom == 1 then
			args = args .. " -Z"
		end

		if vim.g.tmux_navigator_no_wrap == 1 and direction ~= "p" then
			local pos = { h = "left", j = "bottom", k = "top", l = "right" }
			args = string.format('if -F "#{pane_at_%s}" "" "%s"', pos[direction], args)
		end

		vim.fn.system(tmux_executable() .. " -S " .. tmux_socket() .. " " .. args)
		tmux_is_last_pane = true
	else
		tmux_is_last_pane = false
	end
end

-- Key mappings
local function map_keys()
	local opts = { noremap = true, silent = true }

	vim.keymap.set("n", "<C-h>", function() navigate("h") end, opts)
	vim.keymap.set("n", "<C-j>", function() navigate("j") end, opts)
	vim.keymap.set("n", "<C-k>", function() navigate("k") end, opts)
	vim.keymap.set("n", "<C-l>", function() navigate("l") end, opts)
	vim.keymap.set("n", "<C-\\>", function() navigate("p") end, opts)

	if vim.env.TMUX then
		vim.keymap.set("t", "<C-h>", function() if is_fzf() then return "<C-h>" else navigate("h") end end, { expr = true, silent = true })
		vim.keymap.set("t", "<C-j>", function() if is_fzf() then return "<C-j>" else navigate("j") end end, { expr = true, silent = true })
		vim.keymap.set("t", "<C-k>", function() if is_fzf() then return "<C-k>" else navigate("k") end end, { expr = true, silent = true })
		vim.keymap.set("t", "<C-l>", function() if is_fzf() then return "<C-l>" else navigate("l") end end, { expr = true, silent = true })
	end
end

map_keys()
