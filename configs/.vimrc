set nocompatible
set termguicolors
syntax on
set number
set relativenumber
filetype plugin on
filetype plugin indent on
set path+=**

if !isdirectory("/home/benjamin/.vim/pack")
	:!git clone https://github.com/catppuccin/vim.git ~/.vim/pack/vendor/start/catppuccin
	:!git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
endif

colorscheme catppuccin_frappe

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
