source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme desert
highlight Pmenu ctermbg=grey ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=white
highlight Pmenu guibg=grey guifg=black
highlight PmenuSel guibg=blue guifg=white

" grep.vim
let Grep_Path = 'C:\GnuWin32\bin\grep.exe'
let Fgrep_Path = 'C:\GnuWin32\bin\grep.exe -F'
let Egrep_Path = 'C:\GnuWin32\bin\grep.exe -E'
let Grep_Find_Path = 'C:\GnuWin32\bin\find.exe'
let Grep_Xargs_Path = 'C:\GnuWin32\bin\xargs.exe'
let Grep_Shell_Quote_Char = '"'
let Grep_Skip_Dirs = '.svn'
let Grep_Skip_Dirs = '.bzr'
let Grep_Skip_Files = '*.bak *~'

nmap <C-v> <C-v>
cmap <C-v> <C-v>

nmap <C-a> <C-a>
cmap <C-a> <C-a>
