set nocompatible
syntax on
set number
set relativenumber
filetype plugin on
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
