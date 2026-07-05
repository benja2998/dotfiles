set nocompatible
set clipboard=unnamedplus
syntax on
set number
set noswapfile
set relativenumber
set termguicolors
filetype plugin on
set tabstop=4
set noshowmode
set mouse=a
set laststatus=2
set shiftwidth=4
filetype plugin indent on
set path+=**
set background=dark

if !isdirectory(glob("~/.vim/pack"))
	:!git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
	:!git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes
	:!git clone https://github.com/junegunn/fzf.vim ~/.vim/pack/dist/start/fzf.vim
	:!git clone https://codeberg.org/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8
endif

let g:airline_theme='solarized'

colorscheme solarized8

let mapleader = ' '

function! ToggleMarkdownCheckbox() abort
	let l:lnum = line('.')

	let l:line = getline(l:lnum)

	if l:line =~ '\[ \]'
		let l:new = substitute(l:line, '\[ \]', '\[x\]', '')
		call setline(l:lnum, l:new)
	elseif l:line =~ '\[x\]'
		let l:new = substitute(l:line, '\[x\]', '\[ \]', '')
		call setline(l:lnum, l:new)
	endif
endfunction

nnoremap <leader>j :call ToggleMarkdownCheckbox()<CR>
nnoremap <leader>pf :FZF<CR>
