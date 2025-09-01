" sbnc_theme.vim
hi clear
syntax reset
let g:colors_name = "sbnc_theme1"
set background=dark
set t_Co=256

" ----------------------
" Palette (semantic names)
" ----------------------
let s:bg_main        = "#020508"
let s:bg_alt         = "#24426D"
let s:fg_main        = "#C4C4C4"
let s:fg_dim         = "#747474"
let s:fg_muted       = "#a6a6af"
let s:fg_comment     = "#B9ACC2"

let s:accent_error   = "#95bce0"   " errors, warnings, types "blue
let s:accent_keyword = "#d38a86"   " keywords, constants "red
let s:accent_value   = "#d6b77d"   " numbers, strings, labels "orange
let s:accent_func    = "#669CD1"   " functions "blue
let s:accent_stmt    = "#6790AE"   " operators, statements "blue

" ----------------------
" Highlights
" ----------------------

" Normal
execute "hi Normal guifg=" . s:fg_main . " guibg=" . s:bg_main . " gui=NONE ctermbg=NONE"

" Error-related (blue accent)
for group in ['DiffText','ErrorMsg','WarningMsg','PreProc','Exception','Error',
      \ 'DiffDelete','GitGutterDelete','GitGutterChangeDelete','cssIdentifier',
      \ 'cssImportant','Identifier']
  execute "hi " . group . " guifg=" . s:accent_error . " guibg=NONE"
endfor

" Keywords / constants (red accent)
for group in ['PMenuSel','Constant','Repeat','DiffAdd','GitGutterAdd',
      \ 'cssIncludeKeyword','Keyword']
  execute "hi " . group . " guifg=" . s:accent_keyword . " guibg=NONE"
endfor

" Values (yellow accent)
for group in ['IncSearch','Title','PreCondit','Debug','SpecialChar','Conditional',
      \ 'Todo','Special','Label','Delimiter','Number','CursorLineNR','Define',
      \ 'MoreMsg','Tag','String','MatchParen','Macro','DiffChange','GitGutterChange',
      \ 'cssColor']
  execute "hi " . group . " guifg=" . s:accent_value . " guibg=NONE"
endfor

" Types
execute "hi Type guifg=" . s:accent_error . " guibg=NONE"

" Functions
execute "hi Function guifg=" . s:accent_func . " guibg=NONE"

" Muted groups
for group in ['Directory','markdownLinkText','javaScriptBoolean','Include',
      \ 'Storage','cssClassName','cssClassNameDot']
  execute "hi " . group . " guifg=" . s:fg_muted . " guibg=NONE"
endfor

" Statements (cyan accent)
for group in ['Statement','Operator','cssAttr']
  execute "hi " . group . " guifg=" . s:accent_stmt . " guibg=NONE"
endfor

" ----------------------
" UI elements
" ----------------------
execute "hi Pmenu guifg=" . s:fg_main . " guibg=" . s:bg_alt
execute "hi SignColumn guibg=" . s:bg_main
execute "hi Title guifg=" . s:fg_main
execute "hi LineNr guifg=" . s:fg_dim . " guibg=" . s:bg_main
execute "hi NonText guifg=" . s:fg_comment . " guibg=" . s:bg_main
execute "hi Comment guifg=" . s:fg_comment . " gui=italic"
execute "hi SpecialComment guifg=" . s:fg_comment . " gui=italic guibg=NONE"
execute "hi CursorLine guibg=" . s:bg_alt
execute "hi TabLineFill gui=NONE guibg=" . s:bg_alt
execute "hi TabLine guifg=" . s:fg_dim . " guibg=" . s:bg_alt . " gui=NONE"
execute "hi StatusLine gui=bold guibg=" . s:bg_alt . " guifg=" . s:fg_main
execute "hi StatusLineNC gui=NONE guibg=" . s:bg_main . " guifg=" . s:fg_main
execute "hi Search guibg=" . s:fg_comment . " guifg=" . s:fg_main
execute "hi VertSplit gui=NONE guifg=" . s:bg_alt . " guibg=NONE"
execute "hi Visual gui=NONE guibg=" . s:bg_alt
execute "hi IncSearch guifg=#669CD1 guibg=#DCB674 gui=bold"

" Todo-style comments
execute "hi Todo guifg=" . s:accent_value . " guibg=NONE gui=bold"

" Diagnostics (LSP / linter)
execute "hi DiagnosticError guifg=" . s:accent_error . " guibg=NONE"
execute "hi DiagnosticWarn  guifg=" . s:accent_value . " guibg=NONE"
execute "hi DiagnosticInfo  guifg=" . s:fg_muted     . " guibg=NONE"
execute "hi DiagnosticHint  guifg=" . s:fg_comment   . " guibg=NONE"

" underline versions (if you want subtle instead of colored underline)
execute "hi DiagnosticUnderlineError gui=underline guisp=" . s:accent_error
execute "hi DiagnosticUnderlineWarn  gui=underline guisp=" . s:accent_value
execute "hi DiagnosticUnderlineInfo  gui=underline guisp=" . s:fg_muted
execute "hi DiagnosticUnderlineHint  gui=underline guisp=" . s:fg_comment
