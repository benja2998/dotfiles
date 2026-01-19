if !exists('+termguicolors') || !&termguicolors
	finish
endif

if exists('g:colors_name')
	unlet g:colors_name
endif

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'nice_colorscheme'

highlight Cursor		guifg=#221a1b guibg=#ffd6d9
highlight CursorLine		guibg=#2b2223 gui=NONE guisp=NONE guifg=NONE cterm=NONE term=NONE
highlight CursorColumn		guibg=#2b2223
highlight Visual		guifg=#e1d1d2 guibg=#593c3f
highlight LineNr		guifg=#6d6162 guibg=NONE
highlight CursorLineNr		guifg=#faeaeb guibg=NONE gui=bold gui=NONE guisp=NONE cterm=NONE term=NONE
highlight Comment		guifg=#baabac gui=italic
highlight Constant		guifg=#73dce6
highlight String		guifg=#c7d174
highlight Character		guifg=#e1e7b7
highlight Number		guifg=#d7b9ff
highlight Boolean		guifg=#eadafe
highlight Identifier		guifg=#b5c7ff
highlight Function		guifg=#d8e1ff gui=bold
highlight Statement		guifg=#d7b9ff gui=bold
highlight Conditional		guifg=#d7b9ff
highlight Repeat		guifg=#d7b9ff
highlight Label			guifg=#d7b9ff
highlight Keyword		guifg=#ffb0b6 gui=bold
highlight PreProc		guifg=#f3c064
highlight Type			guifg=#c7d174
highlight StorageClass		guifg=#f3c064
highlight Special		guifg=#d8e1ff
highlight SpecialChar		guifg=#d8e1ff
highlight Underlined		guifg=#b5c7ff gui=underline
highlight Ignore		guifg=#362d2e
highlight Error			guifg=#faeaeb guibg=#ffb0b6 gui=bold
highlight Todo			guifg=#221a1b guibg=#f3c064 gui=bold

highlight Search		guifg=#faeaeb guibg=#593c3f
highlight IncSearch		guifg=#faeaeb guibg=#fadeaf
highlight MatchParen		guifg=#faeaeb guibg=#4d4243 gui=bold

highlight Pmenu			guifg=#e1d1d2 guibg=#362d2e
highlight PmenuSel		guifg=#faeaeb guibg=#5c5151 gui=bold
highlight PmenuSbar		guibg=#362d2e
highlight PmenuThumb		guibg=#5c5151

highlight StatusLine		guifg=#faeaeb guibg=#423838 gui=bold
highlight StatusLineNC		guifg=#baabac guibg=#362d2e
highlight TabLine		guifg=#baabac guibg=#2b2223
highlight TabLineSel		guifg=#faeaeb guibg=#423838
highlight TabLineFill		guifg=#baabac guibg=#2b2223

highlight VertSplit		guifg=#1f1718 guibg=#1f1718
highlight Folded		guifg=#baabac guibg=#362d2e

highlight ErrorMsg		guifg=#ffd6d9 guibg=NONE gui=bold
highlight WarningMsg		guifg=#fadeaf guibg=NONE gui=bold
highlight MoreMsg		guifg=#e1e7b7 guibg=NONE gui=bold
highlight Question		guifg=#d8e1ff guibg=NONE gui=bold
highlight Directory		guifg=#c7d174 guibg=NONE gui=bold
highlight Title			guifg=#faeaeb gui=bold

highlight NonText		guifg=#362d2e
highlight SpecialKey		guifg=#362d2e
highlight Whitespace		guifg=#362d2e
highlight Conceal		guifg=#baabac

highlight SpellBad		guisp=#ffb0b6 gui=undercurl
highlight SpellCap		guisp=#f3c064 gui=undercurl
highlight SpellRare		guisp=#d7b9ff gui=undercurl
highlight SpellLocal		guisp=#73dce6 gui=undercurl

highlight SignColumn		guifg=#e1d1d2 guibg=NONE
