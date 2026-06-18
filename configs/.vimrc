set nocompatible
syntax on
set number
set relativenumber
filetype plugin on
filetype plugin indent on
set path+=**

" Set leader key to space
let mapleader = ' '

" Function to toggle markdown checkbox
function! ToggleMarkdownCheckbox() abort
	let l:line = getline('.')
	" Detect checkbox pattern
	if l:line =~ '^\s*[-*+]\s\[-\?x\]'
		" Toggle state
		if l:line =~ '^\s*[-*+]\s\[ \]'
			let l:new = substitute(l:line, '\[ \]', '\[x\]', '')
		elseif l:line =~ '^\s*[-*+]\s\[x\]'
			let l:new = substitute(l:line, '\[x\]', '\[ \]', '')
		else
			return
		endif
		call setline('.', l:new)
	endif
endfunction

nnoremap <leader>j :call ToggleMarkdownCheckbox()<CR>
