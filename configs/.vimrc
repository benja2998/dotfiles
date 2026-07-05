set nocompatible
set timeoutlen=250
syntax on
set number
set relativenumber
filetype plugin on
set tabstop=4
set shiftwidth=4
filetype plugin indent on
set path+=**

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
nnoremap <leader>y "+y
nnoremap <leader>p "+p
inoremap jj <Esc>