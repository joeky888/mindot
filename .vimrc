""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
filetype on " Enable filetype plugin
filetype plugin indent on
set nocompatible " We use Vim, not Vi
set ttyfast " Faster redraw
set lazyredraw " Don't redraw statusline when switching between vim modes
set shortmess=tsIAW " No intro when starting Vim
set expandtab " Insert spaces instead of tabs
set smarttab " Insert spaces according to shiftwidth
set softtabstop=4 " ... and insert four spaces
set shiftwidth=4 " Indent with four spaces
set incsearch " Search as typing
set hlsearch " Highlight search results
set cursorline " Highlight the cursor line
set virtualedit=onemore " Allow the cursor to move just past the end of the line
set history=10000 " Maximum 10000 undo
set wildmenu " Better command-line completion
set wildignorecase " Ignore case when command-line completion
set guicursor=a:ver25-Cursor/lCursor-blinkon0 " disable cursor flashing
set clipboard=unnamed,unnamedplus
set selection=exclusive " Don't select char under cursor
set mouseshape+=a:beam " set cursor shape as modern editors should be
set mouse=a
set autoindent " auto indent
set smartindent " smart indent
set noshowmode " Don't display the current mode
set gdefault " The substitute flag g is on
set hidden " Hide the buffer instead of closing when switching
set backspace=indent,eol,start " The normal behaviour of backspace
set showtabline=2 " Always show tabs
set laststatus=2 " Always show status bar
set whichwrap=<,>,[,] " Alow arrow keys move to previous/next line
set updatetime=1000 " How long will vim backup a file
set autoread " Auto reload content if it changed outside of vim
set tabpagemax=5000 " Max tab pages
set ignorecase " case insensitive but case sensitive in command mode
set showbreak=>\
set mousemodel=extend " Disable right click popup in Gvim
set mousefocus " Focus on mouse hovered
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,utf-16le,utf-16be,default,latin1
set langmenu=en_US.UTF-8 " Set Gvim menu language
let $LANG='en' " Set $LANG variable
set fileformats=unix,dos,mac " Set for terminal vim
set viminfo+=n$HOME/.viminfo " .viminfo location
set synmaxcol=3000 " Don't try to highlight lines with over 3000 characters
set sessionoptions-=options,localoptions,globals,buffers " Don't save these to the session file
set sessionoptions+=winpos,winsize,resize, " Save these to the session file
set nosmartcase " No smartcase
set nowrap " Don't wrap text
set cmdheight=2 "Avoiding the Hit ENTER to continue prompts
set guioptions-=T " Don't show toolbar in Gvim
set guioptions-=t " Don't show tearoff menu items
set guioptions+=b " Show bottom (horizontal) scrollbar in Gvim
set guitabtooltip=%{expand('%:p')} " Use full path in GUI tab tooltip
let g:netrw_list_hide='' " Show all hidden files when using file explorer
let g:netrw_hide=0 " Show all hidden files when using file explorer
let g:netrw_sizestyle="H" " Human-readable file size in file explorer
let g:netrw_liststyle=1 " Like 'ls -al' in file explorer
let g:netrw_timefmt="" " Don't display time in file explorer

"""""""""""""""""""""""""""""""""""""""""""""""""
"                                               "
" ttymouse should set to xterm if using fbterm. "
"                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""

if has("mouse_sgr")
  set ttymouse=sgr " Faster mouse in tty, xterm patch version >= 277
elseif has("mouse_xterm")
  set ttymouse=xterm2 " Faster mouse in tty, xterm patch version from 95 to 276
endif
if executable("fbterm")
  set ttymouse=xterm " Reset to xterm in order to use GPM mouse
endif

autocmd VimEnter * set noerrorbells " Disable Gvim error sound
autocmd VimEnter * set vb t_vb= | set t_vb= " Disable Gvim visual bell
autocmd BufRead,BufNewFile,BufWritePost,BufEnter,FileType,ColorScheme,SessionLoadPost * set iskeyword=a-z,A-Z,48-57,_
autocmd BufRead,BufNewFile,BufWritePost,BufEnter,FileType,ColorScheme,SessionLoadPost * set formatoptions-=cro " Prevent vim inserting new comment lines
" Highlight code area in markdown
let g:markdown_fenced_languages =
\[
  \"c","cpp","java","javascript","ruby","python","vim",
  \"css","html","xml","json","cmake","yaml","sh","conf",
  \"zsh","tmux","debsources","resolv","sudoers","make",
  \"dosbatch","bash=sh","js=javascript"
\]

" Open all cmd args in new tabs
silent tab all

" Modified from https://github.com/Khouba/indent-detector.vim
function! InitIndentVariable(var, value)
  if !exists(a:var)
    if type(a:value) == type("")
      exec 'let ' . a:var . ' = ' . "'" . a:value . "'"
    else
      exec 'let ' . a:var . ' = ' . a:value
    endif
  endif
endfunction

function! IndentDetectorSearchNearby(pat)
  return search(a:pat, 'Wnc', 0, 20) > 0 || search(a:pat, 'Wnb', 0, 20) > 0
endfunction

function! IndentDetectorDetect(autoadjust)
  let leadtab = IndentDetectorSearchNearby('^\t')
  let leadspace = IndentDetectorSearchNearby('^ ')
  if leadtab + leadspace < 2 && IndentDetectorSearchNearby('^\(\t\+ \| \+\t\)') == 0
    if leadtab
      if a:autoadjust
        exec 'setl noexpandtab nosmarttab tabstop='.b:Indent_Detector_tabstop.' shiftwidth='.b:Indent_Detector_shiftwidth.' softtabstop='.b:Indent_Detector_softtabstop
      endif
      return 'tab'
    elseif leadspace
      let spacenum = 0
      if IndentDetectorSearchNearby('^ [^\t ]')
        let spacenum = 1
      elseif IndentDetectorSearchNearby('^  [^\t ]')
        let spacenum = 2
      elseif IndentDetectorSearchNearby('^   [^\t ]')
        let spacenum = 3
      elseif IndentDetectorSearchNearby('^    [^\t ]')
        let spacenum = 4
      elseif IndentDetectorSearchNearby('^     [^\t ]')
        let spacenum = 5
      elseif IndentDetectorSearchNearby('^      [^\t ]')
        let spacenum = 6
      elseif IndentDetectorSearchNearby('^       [^\t ]')
        let spacenum = 7
      elseif IndentDetectorSearchNearby('^        [^\t ]')
        let spacenum = 8
      endif
      if a:autoadjust
        let n = spacenum ? spacenum : b:Indent_Detector_shiftwidth
        exec 'setl expandtab smarttab tabstop='.n.' shiftwidth='.n.' softtabstop='.n
      endif
      return 'space'.(spacenum ? spacenum : '>8')
    else
      if &expandtab
        return 'space'.&softtabstop
      else
        return 'tab'.&tabstop
      endif
    endif
  else
    return 'mixed'
  endif
endfunction

function! GetIndent()
  if !exists('b:fileIndent')
    call InitIndentVariable('b:Indent_Detector_tabstop', &tabstop)
    call InitIndentVariable('b:Indent_Detector_shiftwidth', &shiftwidth)
    call InitIndentVariable('b:Indent_Detector_softtabstop', &softtabstop)
    let b:fileIndent = IndentDetectorDetect(0)
  endif
  return b:fileIndent
endfunction
autocmd BufRead,BufNewFile,BufWritePost,BufAdd,BufNew,FileType,SessionLoadPost * exe "if exists('b:fileIndent') | unlet b:fileIndent | endif" | call GetIndent()

""" Prevent lag when hitting ESC
set ttimeoutlen=10
set timeoutlen=10
au InsertEnter * set ignorecase

function! GetFileInfo()
  let time = strftime("%T")
  let file = expand('%:p')
  let permissions = getfperm(file)
  echom file . " saved at " . time | redraw
  echohl iGreen | echon "     Info     "
  echohl Green | echon  " " . GetFileSize() . ", " . time . ", " . permissions
  echohl None
endfunction
function! GetFileSize()
  let bytes = getfsize(expand('%:p'))
  if bytes <= 0
     return ""
  elseif bytes > 1024*1000*1000
    return (bytes / 1024*1000*1000) . "GB"
  elseif bytes > 1024*1000
    return (bytes / 1024*1000) . "MB"
  elseif bytes > 1024
    return (bytes / 1024) . "KB"
  else
     return bytes . "B"
  endif
endfunction
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Helper functions
function! CreateShortcut(keys, cmd, where, ...)
  let keys = "<" . a:keys . ">"
  if a:where =~ "i"
    let i = (index(a:000,"noTrailingIInInsert") > -1) ? "" : "i"
    let e = (index(a:000,"noLeadingESCInInsert") > -1) ? "" : "<ESC>"
    execute "inoremap " . keys . " " . e .  a:cmd . i
  endif
  if a:where =~ "n"
    execute "nnoremap " . keys . " " . a:cmd
  endif
  if a:where =~ "v"
    let k = (index(a:000,"restoreSelectionAfter") > -1) ? "gv" : ""
    let c = a:cmd
    if index(a:000,"cmdInVisual") > -1
      let c = ":<C-u>" . strpart(a:cmd,1)
    endif
    execute "vnoremap " . keys . " " . c . k
  endif
endfunction
function! TabIsEmpty()
  return winnr('$') == 1 && len(expand('%')) == 0 && line2byte(line('$') + 1) <= 2
endfunction
function! ModifiedQCheck()
  if &modified
    if (confirm("YOU HAVE UNSAVED CHANGES! Wanna quit anyway?", "&Yes\n&No", 2)==1)
      q!
    endif
  else
    silent q
  endif
endfunction
function! ModifiedBDCheck()
  if &modified
    if (confirm("YOU HAVE UNSAVED CHANGES! Wanna quit anyway?", "&Yes\n&No", 2)==1)
      bd!
    endif
  else
    silent bd
  endif
endfunction
function! FileQuit()
  if has("gui_running")
    " help file is not in the buffer list, specially treated
    if (&filetype=="help")
      q
      return
    elseif TabIsEmpty() == 1
      silent q!
      return
    endif
    redir => bufferActive | silent exe 'buffers a' | redir END
    let g:bufferNum = len(split(bufferActive, "\n"))

    if g:bufferNum == 1 && bufname("%") != "" && winnr("$") == 1
      silent bufdo call ModifiedBDCheck()
      return
    endif
  endif

  if TabIsEmpty() == 1
    silent q!
  else
    call ModifiedQCheck()
  endif
endfunction
function! FileSave()
  normal! mj
  let @/ = "" " Clear searching highlight
  execute "%s/\\s\\+$//e"
  let cantSave = "echo \"Can't save the file: \" . v:exception | return"
  let notSaved = "redraw | echo 'This buffer was NOT saved!' | return"
  try
    silent w
  catch /:E45:\|:E505:\|:E212:/
    if (confirm("This buffer is read only! Wanna save it anyway?", "&Yes\n&No", 2)==1)
      try
        silent w!
      catch /:E212:/
        if (confirm("Can't open the file, do you want to save it as root?", "&Yes\n&No", 2)==1)
          try
            w !sudo tee % > /dev/null
            edit!
          catch
            exe cantSave
          endtry
        else
          exe notSaved
        endif
      catch
        exe cantSave
      endtry
    else
      exe notSaved
    endif
  catch /:E32:/
    if (confirm("This buffer has no file to be saved in! Wanna choose it?", "&Yes\n&No", 2)==1)
      execute has("gui_running") ? 'browse confirm saveas %:p:h' : 'call feedkeys("\<ESC>:w ")'
    else
      exe notSaved
    endif
  catch
    exe cantSave
  endtry
  let time = strftime("%T")
  let file = expand('%:p')
  let permissions = getfperm(file)
  echom file . " saved at " . time | redraw
  echohl iGreen | echon "    SAVED     "
  echohl Green | echon  " " . GetFileSize() . ", " . time . ", " . permissions
  echohl None
  try
    normal! `j
  catch /:E20:/
    echohl iBlue | echon "     Info     "
    echohl Blue | echon  " E20: Mark not set, please try again. "
    echohl None
  endtry
endfunction
function! MenuNetrw()
  let c = input("What to you want to do? (M)ake a dir, Make a (F)ile, (R)ename, (D)elete : ")
  if (c == "m" || c == "M")
    normal! d
  elseif (c == "f" || c == "F")
    normal! %
  elseif (c == "r" || c == "R")
    normal! R
  elseif (c == "d" || c == "D")
    normal! D
  endif
endfunction

" Ctrl S - Save
nnoremap <silent> <C-s> :call FileSave()<CR>
inoremap <silent> <C-s> <C-g>u<C-O>:call FileSave()<CR>
vnoremap <silent> <C-s> <ESC>:call FileSave()<CR>
cnoremap <C-s> <C-c>:call FileSave()<CR>

" Tab - Indent
call CreateShortcut("Tab", ">>", "n")
call CreateShortcut("Tab", ">", "v", "restoreSelectionAfter")

" Shift Tab - UnIndent
call CreateShortcut("S-Tab", "<<", "in")
call CreateShortcut("S-Tab", "<", "v", "restoreSelectionAfter")

" autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType * exe 'setlocal dictionary+=$VIMRUNTIME/syntax/'.&filetype.'.vim'
set completeopt=menuone
set complete=.,w,b,t
set complete+=k " Rescan files in the 'dictionary' option
if v:version > 704 || has("patch314") || has('patch-7.4.314')
  set shortmess+=c " Disable autocomplete WarningMsg
endif
if v:version > 704 || has("patch1570") || has('patch-7.4.1570')
  set shortmess+=F " Disable file info on start
endif
let autocomp=1
let g:CharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <ESC>  pumvisible() ? "\<C-e>\<C-g>u" : "\<ESC>"
inoremap <ESC>A <Up>
inoremap <ESC>B <Down>
inoremap <ESC>C <Right>
inoremap <ESC>D <Left>

function! ToggleAutoComplete()
  if g:autocomp
    for l:char in split(g:CharSet, '\zs')
      silent execute "inoremap <silent> <expr> ".l:char." pumvisible() ? '".l:char."' : '".l:char."\<C-n>\<C-p>'"
    endfor
  else
    for l:char in split(g:CharSet, '\zs')
      execute "inoremap ".l:char." ".l:char
    endfor
  endif
  let g:autocomp=g:autocomp ? 0 : 1
endfunction
call ToggleAutoComplete()
command! AutoCompleteEnable  let g:autocomp=1 | call ToggleAutoComplete()
command! AutoCompleteDisable let g:autocomp=0 | call ToggleAutoComplete()

autocmd FileType netrw call KeysInNetrw()
function! KeysInNetrw() " Map keys in file explorer
  " Right to enter
  nmap <buffer> <Right> <CR>
  " Left to go up
  nmap <buffer> <Left> -
  " l - Display info
  nmap <buffer> l qf
  " C-k - Delete files/directories
  nmap <buffer> <C-k> D
  vmap <buffer> <C-k> D
  " v - Enter to visual mode to select files
  nmap <buffer> v V
  " Backspace - go back
  nmap <buffer> <BS> u
  " Space to enter
  nmap <buffer> <Space> <CR>
  " Tab to go down an entry
  nmap <buffer> <Tab> j
endfunction

""" Colors and Statusline
let defaultAccentColor=161
let colorsAndModes= {
  \ 'i' : 39,
  \ 'v' : 82,
  \ 'V' : 226,
  \ '' : 208
\}
let defaultAccentColorGui='#D7005F'
let colorsAndModesGui= {
  \ 'i' : '#00AFFF',
  \ 'v' : '#5FFF00',
  \ 'V' : '#FFFF00',
  \ '' : '#FF8700'
\}
function! LastAccentColor()
  if !exists('b:lastMode')
    let b:lastMode = g:currentmode[mode()]
    call ChangeAccentColor()
  elseif b:lastMode != g:currentmode[mode()]
    let b:lastMode = g:currentmode[mode()]
    call ChangeAccentColor()
  endif
  return ''
endfunction
" autocmd CursorHold,CursorHoldI * call LastAccentColor()
function! ChangeAccentColor()
  let accentColor=get(g:colorsAndModes, mode(), g:defaultAccentColor)
  let accentColorGui=get(g:colorsAndModesGui, mode(), g:defaultAccentColorGui)
  execute 'hi! User1 ctermfg=0 guifg=#000000 ctermbg=' . accentColor . ' guibg=' . accentColorGui
  execute 'hi! User2 ctermbg=0 guibg=#2E3436 ctermfg=' . accentColor . ' guifg=' . accentColorGui
  execute 'hi! User3 ctermfg=0 guifg=#000000 cterm=bold gui=bold ctermbg=' . accentColor . ' guibg=' . accentColorGui
  execute 'hi! TabLineSel ctermfg=0 cterm=bold ctermbg=' . accentColor
  execute 'hi! TabLine ctermbg=0 ctermfg=' . accentColor
  execute 'hi! CursorLineNr ctermfg=' . accentColor . ' guifg=' . accentColorGui
  return ''
endfunction
function! SearchCount()
  " variable b:lastKey = [key, Nth, N]
  if !exists('b:lastKey') | let b:lastKey = [[], 0, 0] | endif
  return b:lastKey[1] . "/" . b:lastKey[2]
endfunction
function! UpdateSearch()
  let pos=getpos('.')
  let key=[@/, b:changedtick]

  let b:lastKey[0] = key

  redir => cnt
    silent exe '%s/' . key[0] . '//gne'
  redir END
  let b:lastKey[2] = str2nr(matchstr( cnt, '\d\+' ))

  redir => nth
    silent exe '0,.s/' . key[0] . '//gne'
  redir END

  let b:lastKey[1] = str2nr(matchstr( nth, '\d\+' ))
  call setpos('.', pos)
endfunction
function! CommandAfterSearch()
  if getcmdtype() == '/'
    return "\<cr>:call UpdateSearch()\<cr>"
  else
    return "\<cr>"
  endif
endfunction
cnoremap <silent> <expr> <CR> CommandAfterSearch()
function! NextSearch()
  let l:line = line(".")
  try
    normal! n
  catch /:E486:/
    echohl iBlue | echon "     Info     "
    echohl Blue | echon  " Nothing found! "
    echohl None
  endtry
  if l:line != line(".")
    let b:lastKey[1]=b:lastKey[1]+1 <= b:lastKey[2] ? b:lastKey[1]+1 : b:lastKey[1]+1-b:lastKey[2]
  endif
endfunction
function! PreviousSearch()
  let l:line = line(".")
  try
    normal! N
  catch /:E486:/
    echohl iBlue | echon "     Info     "
    echohl Blue | echon  " Nothing found! "
    echohl None
  endtry
  if l:line != line(".")
    let b:lastKey[1]=b:lastKey[1]-1 > 0 ? b:lastKey[1]-1 : b:lastKey[1]-1+b:lastKey[2]
  endif
endfunction
nnoremap <silent> n :call NextSearch()<CR>
nnoremap <silent> N :call PreviousSearch()<CR>
function! ReadOnly()
  return (&readonly || !&modifiable) ? 'Read Only ' : ''
endfunction
"  Get all mode in :h mode()
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'VBlock',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'ic' : 'Insert',
    \ 'ix' : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rc' : 'Replace',
    \ 'Rv' : 'VReplace',
    \ 'Rx' : 'Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
\}
set statusline=
set statusline+=%{LastAccentColor()}
set statusline+=%1*\ ***%{toupper(g:currentmode[mode()])}***\  " Current mode
set statusline+=%2*\ %<%F\  " Filepath
set statusline+=%2*\ [%{SearchCount()}] " Nth of N when searching
set statusline+=%2*\ %= " To the right
set statusline+=%2*\ %{toupper((&fenc!=''?&fenc:&enc))}\[%{&ff}] " Encoding & Fileformat
set statusline+=%2*\ %{GetIndent()} " Filetype
set statusline+=%2*\ [%{&filetype}] " Filetype
set statusline+=%2*\ %{ReadOnly()} " ReadOnly Flags
set statusline+=%1*\ \%l/%L(%P)-%c\  " Position

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Modified from tomasr Molokai on Github              "
"                                                     "
" Red         = #F92672, 161,   rgb(249   38    114)  "
" Orange      = #FD971F, 208,   rgb(253   151   31)   "
" Yellow      = #E6DB74, 144,   rgb(230   219   116)  "
" Light Green = #A6E22E, 118,   rgb(166   226   46)   "
" Green       = #00AF00, 34,    rgb(0     175   0)    "
" Blue        = #00AFFF, 81,    rgb(0     175   255)  "
" Light Blue  = #66D9EF, 39,    rgb(102   217   239)  "
" Purple      = #AE81FF, 135,   rgb(174   129   255)  "
" Gray        = #7E8E91, 59,    rgb(126   142   145)  "
" Black       = #1B1D1E, 233,   rgb(27    29    30)   "
" White       = #F8F8F2, 252,   rgb(248   248   242)  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

try
  syntax enable " Enable syntax highlights
  colorscheme darkblue
catch /:E484:\|:E185:/
  " E484: Syntax files not found, using HighlightGlobal"
  autocmd BufRead,BufNewFile,BufWritePost,BufEnter,FileType,ColorScheme,SessionLoadPost * call HighlightGlobal()
  call HighlightGlobal()
endtry
"   set background=dark
highlight clear
syntax reset
set t_Co=256

let g:is_bash=1 " Tell $VIMRUNTIME/syntax/sh.vim that I am using bash
let python_highlight_all = 1 " Tell $VIMRUNTIME/syntax/python.vim to highlight all

" Normal is the background color
hi Normal ctermfg=252 ctermbg=233 cterm=NONE guifg=#F8F8F2 guibg=#1B1D1E gui=NONE
" Visual is the selection color
hi Visual ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00AFFF gui=NONE
" Pmenu is the popup autocomplete color
hi Pmenu ctermfg=255 ctermbg=39 cterm=NONE guifg=White guibg=#00AFFF
hi PmenuSel ctermfg=39 ctermbg=255 cterm=NONE guifg=#00AFFF guibg=White

hi Green      ctermfg=34 ctermbg=NONE cterm=NONE guifg=#00AF00 guibg=NONE gui=NONE
hi iGreen     ctermfg=0 ctermbg=34 cterm=NONE guifg=#000000 guibg=#00AF00 gui=NONE
hi Blue       ctermfg=39 ctermbg=NONE cterm=NONE guifg=#00AFFF guibg=NONE gui=NONE
hi iBlue      ctermfg=0 ctermbg=39 cterm=NONE guifg=#000000 guibg=#00AFFF gui=NONE
hi Search     ctermfg=59 ctermbg=226 cterm=NONE guibg=yellow guifg=black  gui=NONE
hi IncSearch  ctermfg=255 ctermbg=34  cterm=NONE guibg=#00FF00 guifg=black gui=NONE

" Init StatusLine colors
if !exists('b:lastMode') | let b:lastMode = g:currentmode[mode()] | call ChangeAccentColor() | endif

hi Boolean              ctermfg=135     guifg=#AE81FF
hi Character            ctermfg=144     guifg=#E6DB74
hi ColorColumn          ctermbg=236     guibg=#232526
hi Comment              ctermfg=59      guifg=#7E8E91
hi Conditional          ctermfg=161     cterm=none      guifg=#F92672     gui=none
hi Constant             ctermfg=135     cterm=none      guifg=#AE81FF     gui=none
hi Cursor               ctermfg=16      ctermbg=253     guifg=#000000     guibg=#F8F8F0
hi CursorColumn         ctermbg=236     guibg=#293739
hi CursorLine           ctermbg=234     cterm=none      guibg=#293739
hi Debug                ctermfg=225     cterm=none      guifg=#BCA3A3     gui=none
hi Define               ctermfg=81      guifg=#66D9EF
hi Delimiter            ctermfg=241     guifg=#8F8F8F
hi DiffAdd              ctermbg=24      guibg=#13354A
hi DiffChange           ctermfg=181     ctermbg=239     guifg=#89807D     guibg=#4C4745
hi DiffDelete           ctermfg=162     ctermbg=53      guifg=#960050     guibg=#1E0010
hi DiffText             ctermbg=102     cterm=none      guibg=#4C4745     gui=none
hi Directory            ctermfg=81      cterm=none      guifg=#66D9EF     gui=none
hi Error                ctermfg=255     ctermbg=196     guifg=#E6DB74     guibg=#FF3333
hi ErrorMsg             ctermfg=199     ctermbg=16      cterm=none        guifg=#F92672       guibg=#232526     gui=none
hi Exception            ctermfg=118     cterm=none      guifg=#A6E22E     gui=none
hi Float                ctermfg=135     guifg=#AE81FF
hi FoldColumn           ctermfg=67      ctermbg=16      guifg=#465457     guibg=#000000
hi Folded               ctermfg=242     ctermbg=235     cterm=NONE        guifg=#7E8E91       guibg=#272822     gui=NONE
hi Function             ctermfg=118     guifg=#A6E22E
hi Identifier           ctermfg=208     cterm=none      guifg=#FD971F
hi Ignore               ctermfg=244     ctermbg=232     guifg=#808080     guibg=bg
hi Keyword              ctermfg=161     cterm=none      guifg=#F92672     gui=none
hi Label                ctermfg=229     cterm=none      guifg=#E6DB74     gui=none
hi LineNr               ctermfg=250     ctermbg=236     guifg=#465457     guibg=#232526
hi Macro                ctermfg=193     guifg=#C4BE89   gui=none
hi MatchParen           ctermfg=233     ctermbg=208     cterm=none        guifg=#000000       guibg=#FD971F     gui=none
hi MoreMsg              ctermfg=229     guifg=#E6DB74
hi NonText              ctermfg=59      guifg=#465457
hi Number               ctermfg=135     guifg=#AE81FF
hi Operator             ctermfg=161     guifg=#F92672
hi PmenuSbar            ctermbg=232     guibg=#080808
hi PmenuThumb           ctermfg=81      guifg=#66D9EF
hi PreCondit            ctermfg=118     cterm=none      guifg=#A6E22E     gui=none
hi PreProc              ctermfg=118     cterm=none      guifg=#A6E22E
hi Question             ctermfg=81      guifg=#66D9EF
hi Repeat               ctermfg=161     cterm=none      guifg=#F92672     gui=none
hi SignColumn           ctermfg=118     ctermbg=235     guifg=#A6E22E     guibg=#232526
hi Special              ctermfg=81      guifg=#66D9EF   guibg=bg          gui=none
hi SpecialChar          ctermfg=161     cterm=none      guifg=#F92672     gui=none
hi SpecialComment       ctermfg=245     cterm=none      guifg=#7E8E91     gui=none
hi SpecialKey           ctermfg=81      guifg=#66D9EF   gui=none
hi SpellBad             ctermbg=52      cterm=underline
hi SpellCap             ctermbg=17      cterm=underline
hi SpellLocal           ctermbg=17      cterm=underline
hi Statement            ctermfg=161     cterm=none      guifg=#F92672     gui=none
hi StatusLine           ctermfg=238     ctermbg=253     guifg=#455354     guibg=fg
hi StatusLineNC         ctermfg=244     ctermbg=232     guifg=#808080     guibg=#080808
hi StorageClass         ctermfg=208     guifg=#FD971F   gui=none
hi String               ctermfg=144     guifg=#E6DB74
hi Structure            ctermfg=81      guifg=#66D9EF
hi TabLineFill          cterm=none      ctermbg=none    guifg=#1B1D1E     guibg=#1B1D1E
hi Tag                  ctermfg=161     guifg=#F92672   gui=none
hi Title                ctermfg=166     guifg=#EF5939
hi Todo                 ctermfg=231     ctermbg=232     cterm=none        guifg=#FFFFFF       guibg=bg        gui=none
hi Type                 ctermfg=81      cterm=none      guifg=#66D9EF     gui=none
hi Typedef              ctermfg=81      guifg=#66D9EF
hi Underlined           ctermfg=244     cterm=underline guifg=#808080     gui=underline
hi VertSplit            ctermfg=244     ctermbg=232     cterm=none        guifg=#808080       guibg=#080808   gui=none
hi WarningMsg           ctermfg=231     ctermbg=238     cterm=none        guifg=#FFFFFF       guibg=#333333   gui=none
hi WildMenu             ctermfg=81      ctermbg=16      guifg=#66D9EF     guibg=#000000
hi iCursor              guifg=#000000   guibg=#F8F8F0

" Custom file syntax
autocmd BufRead,BufNewFile,BufWritePost,BufAdd,BufEnter,FileType,ColorScheme * call HighlightGlobal()

function! HighlightGlobal()
  if &filetype == "" || &filetype == "text" || &filetype == "conf"
    syntax clear
    syn match alphanumeric  "[A-Za-z0-9_]"
    " Copied from $VIM/syntax/lua.vim
    " integer number
    syn match txtNumber     "\<\d\+\>"
    " floating point number, with dot, optional exponent
    syn match txtNumber     "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, starting with a dot, optional exponent
    syn match txtNumber     "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, without dot, with exponent
    syn match txtNumber     "\<\d\+[eE][-+]\=\d\+\>"
    " Wide characters and non-ascii characters
    syn match nonalphabet   "[\u0021-\u002F]"
    syn match nonalphabet   "[\u003A-\u0040]"
    syn match nonalphabet   "[\u005B-\u0060]"
    syn match nonalphabet   "[\u007B-\u007E]"
    syn match nonalphabet   "[^\u0000-\u007F]"
    syn match lineURL       "\(https\?\|ftps\?\|git\|ssh\|scp\|file\):\/\/[[:alnum:]+&!,\'\"=@;<>\?\:|\^`\*\$%\/_#.\-\[\]\{\}()]*"
    syn match txtComment    "^#.*$"
    syn match txtComment    "\s#.*"
    syn match txtComment    "^;.*"
    hi def link alphanumeric  Function
    hi def link txtNumber     Define
    hi def link lineURL       Green
    hi def link nonalphabet   Conditional
    hi def link txtComment    Comment
  endif
endfunction

if has("gui_running")

  set lines=999 columns=999 " set window Maximized
  if has("multi_byte_ime") || has("xim")
    set iminsert=2 " This could cause statusline color act weirdly
    set imcmdline
    set imsearch=2
  endif

  let g:guifontsize = 14

  if has('win32') || has('win64')
    execute "set guifont=Ubuntu\\ Mono:h".g:guifontsize.",Consolas:h".g:guifontsize
    execute "set guifontwide=DroidMono:h".g:guifontsize.",Sarasa\\ Mono\\ TC:h".g:guifontsize.",NSimsun:h".g:guifontsize
  elseif has("gui_macvim")
    execute "set guifont=Monaco:h".g:guifontsize
    execute "set guifontwide=Hiragino\\ Sans\\ GB:h".g:guifontsize
  else
    execute "set guifont=Ubuntu\\ Mono\\ ".g:guifontsize.",Droid\\ Sans\\ Mono\\ ".g:guifontsize.",Inconsolata\\ ".g:guifontsize.",DejaVu\\ Sans\\ Mono\\ ".g:guifontsize
  endif
endif
