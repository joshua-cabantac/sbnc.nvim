" sbnc_theme.vim
hi clear
syntax reset
let g:colors_name = "sbnc-colors"
set background=dark
set t_Co=256

" sbnc_theme.vim
hi clear
syntax reset
let g:colors_name = "sbnc-colors"
set background=dark
set t_Co=256

" ----------------------
" Palette (base)
" ----------------------0b0d0e
let s:bg_main    = "#000000"
let s:bg_alt     = "#24426D"
let s:fg_main    = "#C4C4C4"
let s:fg_dim     = "#747474"
let s:fg_muted   = "#a6a6af"
let s:fg_comment = "#B9ACC2"

" ----------------------
" Accents (named by COLOR, same hexes as your file)
" ----------------------
let s:accent_aqua  = "#95bce0"   " cool accent kept for non-diagnostic usage
let s:accent_rose  = "#d38a86"   " rose/red accent used for keywords
let s:accent_gold  = "#d6b77d"   " was accent_value / ident (gold/amber)
let s:accent_blue  = "#669CD1"   " was accent_func (blue)
let s:accent_cyan  = "#6790AE"   " was accent_stmt (cyan/blue)
let s:accent_error = "#ff4d4f"   " bright error red
let s:accent_warn  = "#ff6b57"   " bright warning red

" ----------------------
" Highlights (sorted by color buckets)
" ----------------------

" Base
execute "hi Normal guifg=" . s:fg_main . " guibg=" . s:bg_main . " gui=NONE ctermbg=NONE"

" AQUA bucket
for g in ['DiffText','PreProc','Exception',
      \   'DiffDelete','GitGutterDelete','GitGutterChangeDelete','cssIdentifier',
      \   'cssImportant','Identifier','Type']
  execute 'hi ' . g . ' guifg=' . s:accent_aqua . ' guibg=NONE'
endfor

" ERROR bucket
for g in ['ErrorMsg','Error']
  execute 'hi ' . g . ' guifg=' . s:accent_error . ' guibg=NONE'
endfor

" ROSE bucket (keywords / constants per original)
for g in ['PMenuSel','Repeat','DiffAdd','GitGutterAdd','cssIncludeKeyword']
  execute 'hi ' . g . ' guifg=' . s:accent_rose . ' guibg=NONE'
endfor

" WARNING bucket
execute 'hi WarningMsg guifg=' . s:accent_warn . ' guibg=NONE'

execute 'hi Keyword guifg=' . s:accent_rose . ' guibg=NONE gui=italic'
execute 'hi Constant guifg=' . s:accent_rose . ' guibg=NONE gui=bold'

" GOLD bucket (values / literals per original)
for g in ['IncSearch','Title','PreCondit','Debug','SpecialChar','Conditional',
      \   'Todo','Special','Label','Delimiter','Number','CursorLineNr','Define',
      \   'MoreMsg','Tag','String','MatchParen','Macro','DiffChange','GitGutterChange',
      \   'cssColor']
  execute 'hi ' . g . ' guifg=' . s:accent_gold . ' guibg=NONE'
endfor

" BLUE bucket (functions)
execute "hi Function guifg=" . s:accent_blue . " guibg=NONE"

" CYAN bucket (statements / operators)
for g in ['Statement','Operator','cssAttr']
  execute 'hi ' . g . ' guifg=' . s:accent_cyan . ' guibg=NONE'
endfor

" MUTED bucket
for g in ['Directory','markdownLinkText','javaScriptBoolean','Include','Storage','cssClassName','cssClassNameDot']
  execute 'hi ' . g . ' guifg=' . s:fg_muted . ' guibg=NONE'
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
execute "hi Todo guifg=" . s:accent_gold . " guibg=NONE gui=bold"

" ----------------------
" Diagnostics
" ----------------------
execute "hi DiagnosticError guifg=" . s:accent_error . " guibg=NONE"
execute "hi DiagnosticWarn  guifg=" . s:accent_warn . " guibg=NONE"
execute "hi DiagnosticInfo  guifg=" . s:fg_muted    . " guibg=NONE"
execute "hi DiagnosticHint  guifg=" . s:fg_comment  . " guibg=NONE"

execute "hi DiagnosticUnderlineError gui=underline guisp=" . s:accent_error
execute "hi DiagnosticUnderlineWarn  gui=underline guisp=" . s:accent_warn
execute "hi DiagnosticUnderlineInfo  gui=underline guisp=" . s:fg_muted
execute "hi DiagnosticUnderlineHint  gui=underline guisp=" . s:fg_comment

" Explicitly cover common derived diagnostic groups used by signs, virtual text,
" floating windows, trouble lists, and other UI wrappers.
for g in ['DiagnosticSignError','DiagnosticVirtualTextError','DiagnosticFloatingError','DiagnosticVirtualLinesError']
  execute 'hi ' . g . ' guifg=' . s:accent_error . ' guibg=NONE'
endfor

for g in ['DiagnosticSignWarn','DiagnosticVirtualTextWarn','DiagnosticFloatingWarn','DiagnosticVirtualLinesWarn']
  execute 'hi ' . g . ' guifg=' . s:accent_warn . ' guibg=NONE'
endfor
