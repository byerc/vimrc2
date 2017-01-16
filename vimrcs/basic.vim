" General
set nocompatible " vim only
filetype indent on          " load filetype-specific indent files
filetype plugin on

"faster than reaching for esc
inoremap jk <esc> 

let mapleader=","
let g:mapleader = ","

"no need to hit shift
nnoremap ; : 

" Fast saving
nmap <leader>w :w!<cr>

" place cursor between braces
inoremap { {<CR><BS>}<Esc>ko

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set ttymouse=sgr        "fixes issue with mouse not working past 220th column"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
set encoding=utf8           " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac        " Use Unix as the standard file type

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Sounds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git, etc anyway...
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw - file navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Open netrw in resume explore
" nnoremap <leader>nf :call VexToggle(getcwd())<CR>
nnoremap <leader>n :call VexToggle("")<cr>
let g:netrw_banner = 0
let g:netrw_liststyle=3
let g:netrw_preview = 1

fun! VexToggle(dir)
    if exists("t:vex_buf_nr")
        call VexClose()
    else
        call VexOpen(a:dir)
    endif
endf

fun! VexOpen(dir)
    let g:netrw_browse_split=4 " open files in previous window
    let vex_width = 25

    execute "Vexplore " . a:dir
    let t:vex_buf_nr = bufnr("%")
    wincmd H

    call VexSize(vex_width)
endf

fun! VexClose()
    let cur_win_nr = winnr()
    let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

    1wincmd w
    close
    unlet t:vex_buf_nr

    execute (target_nr - 1) . "wincmd w"
    call NormalizeWidths()
endf

fun! VexSize(vex_width)
    execute "vertical resize" . a:vex_width
    set winfixwidth
    call NormalizeWidths()
endf

fun! NormalizeWidths()
    let eadir_pref = &eadirection
    set eadirection=hor
    set equalalways! equalalways!
    let &eadirection = eadir_pref
endf
