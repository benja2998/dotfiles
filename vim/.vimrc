vim9script

###############
#   OPTIONS   #
###############
set shiftwidth=4        # 4 space shifting
set tabstop=4           # 4 space tabs
set smartindent         # smart indentation
set lazyredraw          # lazily redraw
set ttyfast             # assume fast terminal
set number              # show line numbers
set re=1                # disable the stupid new regex engine
set relativenumber      # use relative line numbers
set nocompatible        # disable vi compatibility
set ignorecase          # ignore case
set smartcase           # smart case
set showtabline=2       # always show tabline
set laststatus=2        # always show status line
set noswapfile          # don't use a swap file

###############
#   KEYMAPS   #
###############
g:mapleader = " "
nnoremap <silent> H :tabprev<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap <silent> <leader>c :tabnew<CR>
nnoremap <silent> <leader>q :quit<CR>
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>t <Cmd>call system('tmux split-window -v')<CR>
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>d "+d
nnoremap <silent> <leader>p "+p

###############
# FZF INTEGR- #
# ATION       #
###############
	def g:FzfCallback(tmpfile: string, job: job, status: number) 
	var lines = readfile(tmpfile)
	if !empty(lines)
var selected = trim(lines[0])
	bdelete!
	execute 'edit ' .. selected
	endif
delete(tmpfile)
	enddef

	def g:FzfFiles()
var tmpfile = tempname()
	var buf = term_start('sh -c "fzf > ' .. tmpfile .. '"', {
			'term_finish': 'close',
			'exit_cb': function('g:FzfCallback', [tmpfile])
			})
enddef

	def g:FzfGitFiles()
var tmpfile = tempname()
	var buf = term_start('sh -c "git ls-files ":/" | fzf > ' .. tmpfile .. '"', {
			'term_finish': 'close',
			'exit_cb': function('g:FzfCallback', [tmpfile])
			})
enddef

	def g:FzfBufferCallback(tmpfile: string, job: job, status: number)
	var lines = readfile(tmpfile)
	if !empty(lines)
var selected = trim(lines[0])
	var bufnr = str2nr(matchstr(selected, '^\d\+'))
	if bufnr > 0
	bdelete!
	execute 'buffer ' .. bufnr
	endif
	endif
delete(tmpfile)
	enddef

	def g:FzfBuffers()
var tmpfile = tempname()
	var buflist = getbufinfo({'buflisted': 1})
	var buflines = []
	for buf in buflist
	var name = empty(buf.name) ? '[No Name]' : buf.name
	add(buflines, buf.bufnr .. ': ' .. name)
	endfor

	var bufstr = join(buflines, "\n")
	var buf = term_start('sh -c "echo ' .. shellescape(bufstr) .. ' | fzf > ' .. tmpfile .. '"', {
			'term_finish': 'close',
			'exit_cb': function('g:FzfBufferCallback', [tmpfile])
			})
enddef

nnoremap <silent> <leader>ff <Cmd>call g:FzfFiles()<CR>
nnoremap <silent> <leader>gf <Cmd>call g:FzfGitFiles()<CR>
nnoremap <silent> <leader>bf <Cmd>call g:FzfBuffers()<CR>

###############
# TMUX INTEG- #
# RATION      #
###############
def g:VimNavigate(direction: string)
execute "wincmd " .. direction
enddef

	def g:TmuxNavigate(direction: string)
var previous_winnr = winnr()
	g:VimNavigate(direction)
var current_winnr = winnr()
	if previous_winnr == current_winnr
	var tmux_direction = direction
	if direction == 'h'
	tmux_direction = 'L'
	elseif direction == 'j'
	tmux_direction = 'D'
	elseif direction == 'k'
	tmux_direction = 'U'
	elseif direction == 'l'
	tmux_direction = 'R'
	endif
	system('tmux select-pane -' .. tmux_direction)
	endif
	enddef

	if exists("$TMUX")
	nnoremap <silent> <C-h> <Cmd>call g:TmuxNavigate('h')<CR>
	nnoremap <silent> <C-j> <Cmd>call g:TmuxNavigate('j')<CR>
	nnoremap <silent> <C-k> <Cmd>call g:TmuxNavigate('k')<CR>
	nnoremap <silent> <C-l> <Cmd>call g:TmuxNavigate('l')<CR>
	else
	nnoremap <silent> <C-h> <Cmd>call g:VimNavigate('h')<CR>
	nnoremap <silent> <C-j> <Cmd>call g:VimNavigate('j')<CR>
	nnoremap <silent> <C-k> <Cmd>call g:VimNavigate('k')<CR>
	nnoremap <silent> <C-l> <Cmd>call g:VimNavigate('l')<CR>
	endif
