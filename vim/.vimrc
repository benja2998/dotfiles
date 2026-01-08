vim9script

###############
#   OPTIONS   #
###############
set shiftwidth=4               # 4 space shifting
set tabstop=4                  # 4 space tabs
set lazyredraw                 # lazily redraw
set cursorline                 # highlight current line (most useful when in a tty)
set ttyfast                    # assume fast terminal
set number                     # show line numbers
set re=1                       # disable the stupid new regex engine
set relativenumber             # use relative line numbers
set nocompatible               # disable vi compatibility
set ignorecase                 # ignore case
set smartcase                  # smart case
set showtabline=2              # always show tabline
set laststatus=2               # always show status line
set noswapfile                 # don't use a swap file
set guioptions=                # make gvim look like a serious editor and not a notepad
set smartindent                # better indentation
set cindent                    # enable indentation for C and similar languages
filetype plugin indent on      # enable filetype-specific indentation

###############
#   THEME     #
###############
if exists('$COLORTERM') && ($COLORTERM == 'truecolor')
	if !isdirectory(expand('~/.vim/pack/vendor/start/catppuccin'))
		system('git clone https://github.com/catppuccin/vim.git ~/.vim/pack/vendor/start/catppuccin')
	endif
	set termguicolors
	colorscheme catppuccin_mocha
else
	set notermguicolors
	colorscheme default
endif

###############
#   KEYMAPS   #
###############
g:mapleader = " "
nnoremap <silent> H :tabprev<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap <silent> <leader>c :tabnew<CR>
nnoremap <silent> <leader>t <Cmd>call system('tmux split-window -v')<CR>
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>d "+d
nnoremap <silent> <leader>p "+p

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
