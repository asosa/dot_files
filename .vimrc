" General
set nocompatible          " get out of horrible vi-compatible mode
filetype on               " detect the type of file
set history=10000         " How many lines of history to remember
set cf                    " enable error files and error jumping
filetype plugin indent on " Enable filetype-specific indenting and plugins
set viminfo+=!            " make sure it can save viminfo
set isk+=_,$,@,%,#,-      " none of these should be word dividers, so make them not be
set backup
set swapfile
set iminsert=0
set imsearch=0

" OS dependent
if has("win32")
  set ffs=dos,unix,mac
  set guifont=MS_Gothic:h11:cSHIFTJIS
  set printfont=MS_Gothic:h11:cSHIFTJIS
  set printoptions=number:y
  set backupdir=$HOME/vimfiles/vim_backup
  set directory=$HOME/vimfiles/vim_swap
elseif has('mac')
  set ffs=mac,unix,dos
  set guifont=Osaka一等幅:h14
  set backupdir=$HOME/.vim/vim_backup
  set directory=$HOME/.vim/vim_swap
else
  set ffs=unix,dos,mac
  set guifontset=a14,r14,k14
  set backupdir=$HOME/.vim/vim_backup
  set directory=$HOME/.vim/vim_swap
endif

" Theme/Colors
set background=dark
syntax on
colorscheme desert
highlight Pmenu ctermbg=grey ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=white
highlight Pmenu guibg=grey guifg=black
highlight PmenuSel guibg=blue guifg=white

" Vim UI
set wildmenu     " turn on wild menu
set ruler        " Always show current positions along the bottom
set cmdheight=1  " the command bar is 2 high
set number       " turn on line numbers
set lz           " do not redraw while running macros (much faster) (LazyRedraw)
set hid          " you can change buffer without saving
set backspace=2  " make backspace work normal
set mouse=a      " use mouse everywhere
set report=0     " tell us when anything is changed via :...
set noerrorbells " don't make noise
set fillchars=vert:\ ,stl:\ ,stlnc:\

" Visual Cues
set showmatch    " show matching brackets
set mat=5        " how many tenths of a second to blink matching brackets for
set hlsearch     " do not highlight searched for phrases
set incsearch    " BUT do highlight as you type you search phrase
set ignorecase
set so=10        " Keep 10 lines (top/bottom) for scope
set novisualbell " don't blink
set noerrorbells " no noises
set laststatus=2
set linespace=0
set showcmd
set wrap
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:< " what to show when I hit :set list
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set statusline=%n:\ %<%f\ %m%r%h%w[%{&fileformat}][%{has('multi_byte')&&\ &fileencoding!=''?&fileencoding:&encoding}]\ 0x%B=%b%=%l,%c\ %P

" Indent
set fo=tcrqn     " See Help (complex)
set autoindent   " autoindent
set smartindent  " smartindent
set cindent      " do c-style indenting
set smarttab     " use tabs at the start of a line, spaces elsewhere
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0

" Folding
set foldenable        " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100     " Don't autofold anything (but I can still fold manually)
set foldopen-=search  " don't open folds when you search into them
set foldopen-=undo    " don't open folds when you undo stuff

" CTags
let Tlist_Sort_Type = 'name'       " order by
let Tlist_Use_Right_Window = 1     " split to the right side of the screen
let Tlist_Compart_Format = 1       " show small meny
let Tlist_Exist_OnlyWindow = 1     " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 0 " Do not close tags for other files
let Tlist_Enable_Fold_Column = 0   " Do not show folding tree

" Minibuf
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Enconding
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" key map
imap <C-j> <esc>
nnoremap j gj
nnoremap j gj
nnoremap <unique> fb :FuzzyFinderBuffer<CR>
nnoremap <unique> ff :FuzzyFinderFile<CR>
nnoremap <unique> fm :FuzzyFinderMruFile<CR>
nnoremap <unique> fc :FuzzyFinderMruCmd<CR>
nnoremap <unique> fd :FuzzyFinderDir<CR>

" rails.vim
let g:rails_level=4
let g:rails_default_file="config/database.yml"

" grep.vim
let Grep_Path             = '/bin/grep'
let Fgrep_Path            = '/bin/grep -F'
let Egrep_Path            = '/bin/grep -E'
let Grep_Find_Path        = '/usr/bin/find'
let Grep_Xargs_Path       = '/usr/bin/xargs'
let Grep_Shell_Quote_Char = '"'
let Grep_Skip_Dirs        = '.svn'
let Grep_Skip_Dirs        = '.bzr'
let Grep_Skip_Files       = '*.bak *~'

" FileType settings
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType html set filetype=xhtml
autocmd Filetype html set omnifunc=htmlcomplete#CompleteTags
autocmd Filetype css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" functions
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis