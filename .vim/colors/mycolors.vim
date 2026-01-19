set background=dark
hi clear
let g:colors_name = 'mycolors'
let s:t_Co = has('gui_running') ? 16777216 : str2nr(&t_Co)
let s:tgc = has('termguicolors') && &termguicolors

let g:terminal_ansi_colors = [
      \ '#23071a',
      \ '#a54242',
      \ '#8c9440',
      \ '#de935f',
      \ '#5f819d',
      \ '#85678f',
      \ '#5e8d87',
      \ '#c2a2b8',
      \ '#2f0923',
      \ '#cc6666',
      \ '#b5bd68',
      \ '#f0c674',
      \ '#81a2be',
      \ '#b294bb',
      \ '#8abeb7',
      \ '#ffd5f2' 
      \ ]

hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link CurSearch IncSearch
hi! link CursorLineFold CursorLine
hi! link CursorLineNr CursorLine
hi! link CursorLineSign CursorLine
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link Macro PreProc
hi! link MessageWindow Pmenu
hi! link Number Constant
hi! link Operator Statement
hi! link PmenuExtraSel PmenuSel
hi! link PmenuKindSel PmenuSel
hi! link PopupNotification Todo
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabLineSel StatusLine
hi! link Tag Special
hi! link Terminal Normal
hi! link Typedef Type
hi! link lCursor Cursor

hi Normal guifg=#ffd5f2 guibg=#380c2a guisp=NONE gui=NONE ctermfg=254 ctermbg=233 cterm=NONE term=NONE

hi ColorColumn guifg=NONE guibg=#2f0923 guisp=NONE gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE term=reverse
hi Comment guifg=#c2a2b8 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE term=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=NONE
hi Constant guifg=#f0c674 guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE term=NONE
hi Cursor guifg=#380c2a guibg=#ffd5f2 guisp=NONE gui=NONE ctermfg=233 ctermbg=255 cterm=NONE term=reverse
hi CursorColumn guifg=NONE guibg=#2f0923 guisp=NONE gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE term=NONE
hi CursorIM guifg=#380c2a guibg=#ffd5f2 guisp=NONE gui=NONE ctermfg=233 ctermbg=255 cterm=NONE term=NONE
hi CursorLine guifg=NONE guibg=#450f34 guisp=NONE gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE term=underline
hi DiffAdd guifg=#b5bd68 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=150 ctermbg=52 cterm=reverse term=reverse
hi DiffChange guifg=#c2a2b8 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=145 ctermbg=52 cterm=reverse term=NONE
hi DiffDelete guifg=#cc6666 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=167 ctermbg=52 cterm=reverse term=reverse
hi DiffText guifg=#ffd5f2 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=255 ctermbg=52 cterm=reverse term=reverse
hi Directory guifg=#8abeb7 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi EndOfBuffer guifg=#c2a2b8 guibg=#380c2a guisp=NONE gui=NONE ctermfg=145 ctermbg=233 cterm=NONE term=NONE
hi Error guifg=#a54242 guibg=#ffd5f2 guisp=NONE gui=reverse ctermfg=167 ctermbg=255 cterm=reverse term=bold,reverse
hi ErrorMsg guifg=#ffd5f2 guibg=#a54242 guisp=NONE gui=NONE ctermfg=255 ctermbg=167 cterm=NONE term=bold,reverse
hi FoldColumn guifg=#81a2be guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE term=NONE
hi Folded guifg=#de935f guibg=#380c2a guisp=NONE gui=reverse ctermfg=179 ctermbg=233 cterm=reverse term=NONE
hi Identifier guifg=#8abeb7 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi Ignore guifg=#23071a guibg=NONE guisp=NONE gui=NONE ctermfg=233 ctermbg=NONE cterm=NONE term=NONE
hi IncSearch guifg=#de935f guibg=#380c2a guisp=NONE gui=reverse ctermfg=179 ctermbg=233 cterm=reverse term=bold,reverse,underline
hi LineNr guifg=#c2a2b8 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE term=NONE
hi MatchParen guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse term=bold,underline
hi ModeMsg guifg=#380c2a guibg=#b5bd68 guisp=NONE gui=NONE ctermfg=233 ctermbg=151 cterm=NONE term=bold
hi MoreMsg guifg=#8abeb7 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi NonText guifg=#23071a guibg=#380c2a guisp=NONE gui=NONE ctermfg=233 ctermbg=233 cterm=NONE term=NONE
hi Pmenu guifg=#380c2a guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=233 ctermbg=145 cterm=NONE term=reverse
hi PmenuExtra guifg=#23071a guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=233 ctermbg=145 cterm=NONE term=NONE
hi PmenuKind guifg=#23071a guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=233 ctermbg=145 cterm=NONE term=NONE
hi PmenuMatch guifg=#b294bb guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=140 ctermbg=145 cterm=NONE term=NONE
hi PmenuMatchSel guifg=#b294bb guibg=#8c9440 guisp=NONE gui=NONE ctermfg=140 ctermbg=106 cterm=NONE term=NONE
hi PmenuSbar guifg=#c2a2b8 guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=145 ctermbg=145 cterm=NONE term=reverse
hi PmenuSel guifg=#380c2a guibg=#8c9440 guisp=NONE gui=NONE ctermfg=233 ctermbg=106 cterm=NONE term=bold
hi PmenuThumb guifg=#23071a guibg=#23071a guisp=NONE gui=NONE ctermfg=233 ctermbg=233 cterm=NONE term=NONE
hi PreProc guifg=#81a2be guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE term=NONE
hi Question guifg=#b5bd68 guibg=NONE guisp=NONE gui=NONE ctermfg=150 ctermbg=NONE cterm=NONE term=standout
hi QuickFixLine guifg=#cc6666 guibg=#380c2a guisp=NONE gui=reverse ctermfg=167 ctermbg=233 cterm=reverse term=NONE
hi Search guifg=#8abeb7 guibg=#380c2a guisp=NONE gui=reverse ctermfg=109 ctermbg=233 cterm=reverse term=reverse
hi SignColumn guifg=#81a2be guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE term=reverse
hi Special guifg=#b5bd68 guibg=NONE guisp=NONE gui=NONE ctermfg=150 ctermbg=NONE cterm=NONE term=NONE
hi SpecialKey guifg=#23071a guibg=NONE guisp=NONE gui=NONE ctermfg=233 ctermbg=NONE cterm=NONE term=bold
hi SpellBad guifg=NONE guibg=NONE guisp=#cc6666 gui=undercurl ctermfg=167 ctermbg=NONE cterm=underline term=underline
hi SpellCap guifg=NONE guibg=NONE guisp=#b5bd68 gui=undercurl ctermfg=150 ctermbg=NONE cterm=underline term=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#ffd5f2 gui=undercurl ctermfg=255 ctermbg=NONE cterm=underline term=underline
hi SpellRare guifg=NONE guibg=NONE guisp=#cc6666 gui=undercurl ctermfg=167 ctermbg=NONE cterm=underline term=underline
hi Statement guifg=#b294bb guibg=NONE guisp=NONE gui=NONE ctermfg=140 ctermbg=NONE cterm=NONE term=NONE
hi StatusLine guifg=#380c2a guibg=#ffd5f2 guisp=NONE gui=NONE ctermfg=233 ctermbg=255 cterm=NONE term=bold,reverse
hi StatusLineNC guifg=#380c2a guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=233 ctermbg=145 cterm=NONE term=bold,underline
hi Title guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=NONE
hi TitleBar guifg=#ffd5f2 guibg=#2f0923 guisp=NONE gui=NONE ctermfg=255 ctermbg=52 cterm=NONE term=NONE
hi TitleBarNC guifg=#c2a2b8 guibg=#23071a guisp=NONE gui=NONE ctermfg=145 ctermbg=233 cterm=NONE term=NONE
hi Todo guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse term=bold,reverse
hi ToolbarButton guifg=#ffd5f2 guibg=#85678f guisp=NONE gui=NONE ctermfg=255 ctermbg=140 cterm=NONE term=bold,reverse
hi ToolbarLine guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi Type guifg=#cc6666 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE term=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline term=underline
hi VertSplit guifg=#c2a2b8 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE term=NONE
hi Visual guifg=#380c2a guibg=#8abeb7 guisp=NONE gui=NONE ctermfg=233 ctermbg=109 cterm=NONE term=reverse
hi VisualNOS guifg=#380c2a guibg=#ffd5f2 guisp=NONE gui=NONE ctermfg=233 ctermbg=255 cterm=NONE term=NONE
hi WarningMsg guifg=#b294bb guibg=NONE guisp=NONE gui=NONE ctermfg=140 ctermbg=NONE cterm=NONE term=standout
hi WildMenu guifg=#380c2a guibg=#c2a2b8 guisp=NONE gui=NONE ctermfg=233 ctermbg=145 cterm=NONE term=bold
hi debugBreakpoint guifg=#b5bd68 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=150 ctermbg=52 cterm=reverse term=reverse
hi debugPC guifg=#8abeb7 guibg=#2f0923 guisp=NONE gui=reverse ctermfg=109 ctermbg=52 cterm=reverse term=reverse

if s:tgc || s:t_Co >= 256
  finish
endif

if s:t_Co >= 16
  hi! link PmenuExtraSel PmenuSel
  hi! link PmenuKindSel PmenuSel
  hi Normal ctermfg=white ctermbg=black cterm=NONE
  hi ColorColumn ctermfg=white ctermbg=darkred cterm=NONE
  hi Comment ctermfg=blue ctermbg=NONE cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Constant ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=black ctermbg=yellow cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=blue cterm=NONE
  hi CursorIM ctermfg=black ctermbg=yellow cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi DiffAdd ctermfg=darkgreen ctermbg=white cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=white cterm=reverse
  hi DiffDelete ctermfg=darkmagenta ctermbg=white cterm=reverse
  hi DiffText ctermfg=grey ctermbg=black cterm=reverse
  hi Directory ctermfg=cyan ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=blue ctermbg=black cterm=NONE
  hi Error ctermfg=red ctermbg=white cterm=reverse
  hi ErrorMsg ctermfg=white ctermbg=red cterm=NONE
  hi FoldColumn ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Folded ctermfg=darkyellow ctermbg=black cterm=reverse
  hi Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=darkyellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=blue ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ModeMsg ctermfg=black ctermbg=green cterm=NONE
  hi MoreMsg ctermfg=cyan ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgray ctermbg=black cterm=NONE
  hi Pmenu ctermfg=black ctermbg=white cterm=NONE
  hi PmenuExtra ctermfg=darkgray ctermbg=white cterm=NONE
  hi PmenuKind ctermfg=darkgray ctermbg=white cterm=NONE
  hi PmenuMatch ctermfg=black ctermbg=white cterm=bold
  hi PmenuMatchSel ctermfg=white ctermbg=blue cterm=bold
  hi PmenuSbar ctermfg=gray ctermbg=gray cterm=NONE
  hi PmenuSel ctermfg=white ctermbg=blue cterm=NONE
  hi PmenuThumb ctermfg=darkgray ctermbg=darkgray cterm=NONE
  hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Question ctermfg=green ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=magenta ctermbg=black cterm=reverse
  hi Search ctermfg=cyan ctermbg=black cterm=reverse
  hi SignColumn ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Special ctermfg=green ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=green ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=white ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Statement ctermfg=magenta ctermbg=NONE cterm=NONE
  hi StatusLine ctermfg=white ctermbg=black cterm=reverse
  hi StatusLineNC ctermfg=darkgray ctermbg=gray cterm=reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TitleBar ctermfg=white ctermbg=black cterm=NONE
  hi TitleBarNC ctermfg=gray ctermbg=black cterm=NONE
  hi Todo ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=white ctermbg=darkgray cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Type ctermfg=red ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi VertSplit ctermfg=blue ctermbg=NONE cterm=NONE
  hi Visual ctermfg=black ctermbg=darkcyan cterm=NONE
  hi VisualNOS ctermfg=black ctermbg=white cterm=NONE
  hi WarningMsg ctermfg=magenta ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=white ctermbg=blue cterm=NONE
  hi debugBreakpoint ctermfg=green ctermbg=darkblue cterm=reverse
  hi debugPC ctermfg=cyan ctermbg=darkblue cterm=reverse
  finish
endif

if s:t_Co >= 8
  hi! link PmenuExtra Pmenu
  hi! link PmenuExtraSel PmenuSel
  hi! link PmenuKind Pmenu
  hi! link PmenuKindSel PmenuSel
  hi Normal ctermfg=gray ctermbg=black cterm=NONE
  hi ColorColumn ctermfg=white ctermbg=darkred cterm=NONE
  hi Comment ctermfg=blue ctermbg=NONE cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Constant ctermfg=yellow ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=black ctermbg=yellow cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=blue cterm=NONE
  hi CursorIM ctermfg=black ctermbg=yellow cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi DiffAdd ctermfg=darkgreen ctermbg=white cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=white cterm=reverse
  hi DiffDelete ctermfg=darkmagenta ctermbg=white cterm=reverse
  hi DiffText ctermfg=grey ctermbg=black cterm=reverse
  hi Directory ctermfg=cyan ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=blue ctermbg=black cterm=NONE
  hi Error ctermfg=red ctermbg=white cterm=reverse
  hi ErrorMsg ctermfg=white ctermbg=red cterm=NONE
  hi FoldColumn ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Folded ctermfg=darkyellow ctermbg=black cterm=reverse
  hi Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=darkyellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=blue ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ModeMsg ctermfg=black ctermbg=green cterm=NONE
  hi MoreMsg ctermfg=cyan ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgray ctermbg=black cterm=NONE
  hi Pmenu ctermfg=black ctermbg=white cterm=NONE
  hi PmenuMatch ctermfg=black ctermbg=white cterm=bold
  hi PmenuMatchSel ctermfg=white ctermbg=blue cterm=bold
  hi PmenuSbar ctermfg=white ctermbg=white cterm=NONE
  hi PmenuSel ctermfg=white ctermbg=blue cterm=NONE
  hi PmenuThumb ctermfg=blue ctermbg=blue cterm=NONE
  hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Question ctermfg=green ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=magenta ctermbg=black cterm=reverse
  hi Search ctermfg=cyan ctermbg=black cterm=reverse
  hi SignColumn ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Special ctermfg=green ctermbg=NONE cterm=NONE
  hi SpecialKey ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=green ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=white ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Statement ctermfg=magenta ctermbg=NONE cterm=NONE
  hi StatusLine ctermfg=white ctermbg=black cterm=reverse
  hi StatusLineNC ctermbfg=darkgray ctermbg=gray cterm=bold,reverse
  hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TitleBar ctermfg=white ctermbg=black cterm=NONE
  hi TitleBarNC ctermfg=gray ctermbg=black cterm=NONE
  hi Todo ctermfg=NONE ctermbg=NONE cterm=reverse
  hi ToolbarButton ctermfg=white ctermbg=darkgray cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Type ctermfg=red ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi VertSplit ctermfg=blue ctermbg=NONE cterm=NONE
  hi Visual ctermfg=black ctermbg=darkcyan cterm=NONE
  hi VisualNOS ctermfg=black ctermbg=white cterm=NONE
  hi WarningMsg ctermfg=magenta ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=white ctermbg=blue cterm=NONE
  hi debugBreakpoint ctermfg=green ctermbg=darkblue cterm=reverse
  hi debugPC ctermfg=cyan ctermbg=darkblue cterm=reverse
  finish
endif

if s:t_Co >= 0
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineNr term=bold
  hi CursorLineSign term=underline
  hi Float term=NONE
  hi Function term=NONE
  hi Number term=NONE
  hi StatusLineTerm term=bold,reverse
  hi StatusLineTermNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi TabLineSel term=bold,reverse
  hi Terminal term=NONE
  finish
endif

" vim: et ts=8 sw=2 sts=2
