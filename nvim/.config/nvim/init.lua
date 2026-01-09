vim.loader.enable()

-- [[ Checks ]] --
if vim.fn.has("nvim-0.12") == 0 then
	error("Version is too old!")
end

-- [[ Options ]] --
vim.o.shiftwidth       = 4       -- 4 space indenting
vim.o.tabstop          = 4       -- 4 space tabs
vim.o.smartindent      = true    -- smart indentation
vim.o.lazyredraw       = true    -- lazily redraw
vim.o.ttyfast          = true    -- assume fast terminal
vim.o.number           = true    -- enable line numbers
vim.o.ignorecase       = true    -- ignore case
vim.o.smartcase        = true    -- smart case
vim.o.smartindent      = true    -- smart indentation
vim.o.cindent          = true    -- better C indentation
vim.o.cursorline       = true    -- highlight current line (most useful when in a tty)
vim.o.relativenumber   = true    -- use relative line numbers
vim.o.showtabline      = 2       -- always show tab line
vim.o.laststatus       = 3       -- only use one status line
vim.o.swapfile         = false   -- no swap file
vim.o.hlsearch         = false   -- don't highlight on searches

-- [[ Netrw ]] --
vim.g.netrw_banner     = false   -- no banner
vim.g.netrw_liststyle  = 3       -- tree list style
vim.g.netrw_winsize    = 25      -- window size 25

-- [[ Theme ]] --
if vim.env.COLORTERM then
	vim.pack.add({"https://github.com/catppuccin/nvim"})
	vim.o.termguicolors = true
	vim.cmd("colorscheme catppuccin-mocha")
else
	vim.o.termguicolors = false
	vim.cmd("colorscheme default")
end

-- [[ Keymaps ]] --
vim.g.mapleader = " "
vim.keymap.set('n', 'H', ':tabprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>t', function() vim.fn.system('tmux split-window -v -p 33') end, { silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('v', '<leader>d', '"+d', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>', { silent = true })
vim.keymap.set('n', '<leader>w', ':write<CR>', { silent = true })
vim.keymap.set('n', '<leader>x', ':quit<CR>', { silent = true })
vim.keymap.set('n', '<leader>r', ':restart<CR>', { silent = true })
vim.keymap.set('n', '<leader>qf', ':FzfLua quickfix<CR>', { silent = true })
vim.keymap.set('n', '<leader>gf', ':FzfLua git_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', { silent = true })
vim.keymap.set('n', '<leader>lf', ':FzfLua live_grep<CR>', { silent = true })

-- [[ Fuzzy finding ]] --
vim.pack.add({"https://github.com/ibhagwan/fzf-lua"})

-- [[ Tmux Integration ]] --
function VimNavigate(direction)
	vim.cmd('wincmd ' .. direction)
end

function TmuxNavigate(direction)
	local previous_winnr = vim.fn.winnr()
	VimNavigate(direction)
	local current_winnr = vim.fn.winnr()

	if previous_winnr == current_winnr then
		local tmux_direction = direction
		if direction == 'h' then
			tmux_direction = 'L'
		elseif direction == 'j' then
			tmux_direction = 'D'
		elseif direction == 'k' then
			tmux_direction = 'U'
		elseif direction == 'l' then
			tmux_direction = 'R'
		end
		vim.fn.system('tmux select-pane -' .. tmux_direction)
	end
end

if vim.env.TMUX then
	vim.keymap.set('n', '<C-h>', function() TmuxNavigate('h') end, { silent = true })
	vim.keymap.set('n', '<C-j>', function() TmuxNavigate('j') end, { silent = true })
	vim.keymap.set('n', '<C-k>', function() TmuxNavigate('k') end, { silent = true })
	vim.keymap.set('n', '<C-l>', function() TmuxNavigate('l') end, { silent = true })
else
	vim.keymap.set('n', '<C-h>', function() VimNavigate('h') end, { silent = true })
	vim.keymap.set('n', '<C-j>', function() VimNavigate('j') end, { silent = true })
	vim.keymap.set('n', '<C-k>', function() VimNavigate('k') end, { silent = true })
	vim.keymap.set('n', '<C-l>', function() VimNavigate('l') end, { silent = true })
end
