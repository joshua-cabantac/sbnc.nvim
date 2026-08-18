" iterm_custom.vim
hi clear
syntax reset
let g:colors_name = "iterm_custom"
set background=dark
set t_Co=256

" ----------------------
" Palette
" ----------------------
let s:bg_main    = "#000000"
let s:bg_alt     = "#38547d"
let s:bg_float   = "#2c2c2c"

let s:fg_main    = "#cfcfcf"
let s:fg_dim     = "#555555"
let s:fg_muted   = "#777777"
let s:fg_comment = "#c4bbcc"

" ----------------------
" Accents
" ----------------------
let s:accent_rose     = "#d3a09a"
let s:accent_gold     = "#dac496"
let s:accent_lavender = "#acc7e3"
let s:accent_blue     = "#83acd6"
let s:accent_cyan     = "#82a0b9"
let s:accent_purple   = "#c4bbcc"
let s:accent_search   = "#dac496"
let s:accent_link     = "#255ab5"

" ----------------------
" Base
" ----------------------
execute "hi Normal guifg=" . s:fg_main . " guibg=" . s:bg_main . " gui=NONE ctermbg=NONE"
execute "hi NormalFloat guifg=" . s:fg_main . " guibg=" . s:bg_float
execute "hi FloatBorder guifg=" . s:accent_blue . " guibg=" . s:bg_float

" ----------------------
" ROSE bucket
" ----------------------
for g in ['Constant','Number','Boolean','Character','Exception','Error','ErrorMsg','WarningMsg']
  execute 'hi ' . g . ' guifg=' . s:accent_rose . ' guibg=NONE'
endfor

" ----------------------
" GOLD bucket
" ----------------------
for g in ['String','Conditional','Repeat','Label','SpecialChar','Todo','MatchParen','CursorLineNr']
  execute 'hi ' . g . ' guifg=' . s:accent_gold . ' guibg=NONE'
endfor

" ----------------------
" BLUE bucket
" ----------------------
for g in ['Identifier','Function','Include','Directory','cssIdentifier']
  execute 'hi ' . g . ' guifg=' . s:accent_blue . ' guibg=NONE'
endfor

" ----------------------
" CYAN bucket
" ----------------------
for g in ['Statement','Operator','Keyword','PreProc','Define','Macro','cssAttr']
  execute 'hi ' . g . ' guifg=' . s:accent_cyan . ' guibg=NONE'
endfor

execute 'hi Keyword guifg=' . s:accent_cyan . ' guibg=NONE gui=italic'

" ----------------------
" PURPLE / LAVENDER bucket
" ----------------------
for g in ['Type','Special','Delimiter','Tag','Title']
  execute 'hi ' . g . ' guifg=' . s:accent_purple . ' guibg=NONE'
endfor

execute "hi Comment guifg=" . s:fg_comment . " guibg=NONE gui=italic"
execute "hi SpecialComment guifg=" . s:fg_comment . " guibg=NONE gui=italic"

" ----------------------
" Muted
" ----------------------
for g in ['NonText','EndOfBuffer','Ignore']
  execute 'hi ' . g . ' guifg=' . s:fg_muted . ' guibg=NONE'
endfor

" ----------------------
" UI
" ----------------------
execute "hi Cursor guifg=" . s:bg_main . " guibg=" . s:fg_main
execute "hi CursorLine guibg=#0d0d0d"
execute "hi LineNr guifg=" . s:fg_dim . " guibg=" . s:bg_main
execute "hi SignColumn guibg=" . s:bg_main
execute "hi Visual gui=NONE guibg=" . s:bg_alt
execute "hi Search guifg=" . s:bg_main . " guibg=" . s:accent_search
execute "hi IncSearch guifg=" . s:bg_main . " guibg=" . s:accent_rose . " gui=bold"

execute "hi Pmenu guifg=" . s:fg_main . " guibg=" . s:bg_float
execute "hi PmenuSel guifg=" . s:bg_main . " guibg=" . s:accent_blue
execute "hi StatusLine gui=bold guifg=" . s:fg_main . " guibg=" . s:bg_float
execute "hi StatusLineNC gui=NONE guifg=" . s:fg_muted . " guibg=" . s:bg_main
execute "hi VertSplit gui=NONE guifg=" . s:bg_float . " guibg=NONE"
execute "hi WinSeparator gui=NONE guifg=" . s:bg_float . " guibg=NONE"
execute "hi TabLineFill gui=NONE guibg=" . s:bg_float
execute "hi TabLine guifg=" . s:fg_dim . " guibg=" . s:bg_float . " gui=NONE"

execute "hi Underlined guifg=" . s:accent_link . " gui=underline"
execute "hi Todo guifg=" . s:accent_gold . " guibg=NONE gui=bold"

" ----------------------
" Diagnostics
" ----------------------
execute "hi DiagnosticError guifg=" . s:accent_rose . " guibg=NONE"
execute "hi DiagnosticWarn  guifg=" . s:accent_gold . " guibg=NONE"
execute "hi DiagnosticInfo  guifg=" . s:accent_blue . " guibg=NONE"
execute "hi DiagnosticHint  guifg=" . s:accent_cyan . " guibg=NONE"

execute "hi DiagnosticUnderlineError gui=underline guisp=" . s:accent_rose
execute "hi DiagnosticUnderlineWarn  gui=underline guisp=" . s:accent_gold
execute "hi DiagnosticUnderlineInfo  gui=underline guisp=" . s:accent_blue
execute "hi DiagnosticUnderlineHint  gui=underline guisp=" . s:accent_cyan

" ----------------------
" Tree-sitter
" ----------------------
hi link @comment Comment
hi link @string String
hi link @number Number
hi link @boolean Boolean
hi link @function Function
hi @function.call guifg=#acc7e3
hi link @keyword Keyword
hi link @type Type
hi @variable guifg=#cfcfcf
hi @property guifg=#83acd6
hi @constructor guifg=#c4bbcc
hi @punctuation guifg=#cfcfcf
hi @operator guifg=#cfcfcf
