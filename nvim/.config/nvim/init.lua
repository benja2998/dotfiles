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
vim.o.cursorline       = true    -- highlight current line (most useful when in a tty)
vim.o.relativenumber   = true    -- use relative line numbers
vim.o.showtabline      = 2       -- always show tab line
vim.o.laststatus       = 3       -- only use one status line
vim.o.swapfile         = false   -- no swap file

-- [[ Theme ]] --
if vim.env.COLORTERM then
	vim.pack.add({"https://github.com/catppuccin/nvim"})
	vim.o.termguicolors = true
	vim.cmd("colorscheme catppuccin-mocha")
end

-- [[ Fzf Integration ]] --
function FzfCallback(tmpfile, job_id, exit_code, event_type)
	local f = io.open(tmpfile, 'r')
	if f then
		local lines = {}
		for line in f:lines() do
			table.insert(lines, line)
		end
		f:close()

		if #lines > 0 then
			local selected = vim.trim(lines[1])
			vim.cmd('edit ' .. vim.fn.fnameescape(selected))
		end

		os.remove(tmpfile)
	end
end

function FzfFiles()
	local tmpfile = vim.fn.tempname()
	vim.cmd('enew')
	vim.fn.termopen('fd -H -I -t f . . | fzf > ' .. tmpfile, {
		on_exit = function(job_id, exit_code, event_type)
			FzfCallback(tmpfile, job_id, exit_code, event_type)
		end
	})
	vim.cmd('startinsert')
end

function FzfGitFiles()
	local tmpfile = vim.fn.tempname()
	vim.cmd('enew')
	vim.fn.termopen('git ls-files ":/" | fzf > ' .. tmpfile, {
		on_exit = function(job_id, exit_code, event_type)
			FzfCallback(tmpfile, job_id, exit_code, event_type)
		end
	})
	vim.cmd('startinsert')
end

function FzfBufferCallback(tmpfile, job_id, exit_code, event_type)
	local f = io.open(tmpfile, 'r')
	if f then
		local lines = {}
		for line in f:lines() do
			table.insert(lines, line)
		end
		f:close()

		if #lines > 0 then
			local selected = vim.trim(lines[1])
			local bufnr = tonumber(selected:match('^(%d+)'))
			if bufnr and bufnr > 0 then
				vim.cmd('buffer ' .. bufnr)
			end
		end

		os.remove(tmpfile)
	end
end

function FzfBuffers()
	local tmpfile = vim.fn.tempname()
	local buflist = vim.fn.getbufinfo({buflisted = 1})
	local buflines = {}

	for _, buf in ipairs(buflist) do
		local name = buf.name == '' and '[No Name]' or buf.name
		table.insert(buflines, buf.bufnr .. ': ' .. name)
	end

	local bufstr = table.concat(buflines, "\n")
	vim.cmd('enew')
	vim.fn.termopen('echo ' .. vim.fn.shellescape(bufstr) .. ' | fzf > ' .. tmpfile, {
		on_exit = function(job_id, exit_code, event_type)
			FzfBufferCallback(tmpfile, job_id, exit_code, event_type)
		end
	})
	vim.cmd('startinsert')
end

-- [[ Keymaps ]] --
vim.g.mapleader = " "
vim.keymap.set('n', 'H', ':tabprev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { silent = true })
vim.keymap.set('n', '<leader>w', ':write<CR>', { silent = true })
vim.keymap.set('n', '<leader>t', function() vim.fn.system('tmux split-window -v') end, { silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
vim.keymap.set('v', '<leader>d', '"+d', { silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { silent = true })
vim.keymap.set('n', '<leader>ff', FzfFiles, { silent = true })
vim.keymap.set('n', '<leader>gf', FzfGitFiles, { silent = true })
vim.keymap.set('n', '<leader>bf', FzfBuffers, { silent = true })

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
