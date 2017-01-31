""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " vim only
set nomodeline
filetype indent on  " load filetype-specific indent files
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
" inoremap { {<CR><BS>}<Esc>ko

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4               " number of visual spaces per TAB
set expandtab               " tabs are spaces
set smarttab
set softtabstop=4           " number of spaces in tab when editing
set shiftwidth=4
set autoindent              " indent when creating new line
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu                " deals with autocomplete on the command line. See ':help wildmenu'
set ttyfast                 " faster redraw
set lazyredraw              " Don't redraw while executing macros (good performance config)
set number                  " show line numbers
set showcmd                 " show command in bottom bar
set nocursorline            " highlight current line
set list                    " show whitespace
set listchars+=space:.,tab:➝\ 
" configure backspace so it acts as it should
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set ttymouse=sgr        "fixes issue with mouse not working past 220th column"
endif
set clipboard=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch               " higlight matching parenthesis
set ignorecase              " ignore case when searching
set incsearch               " search as characters are entered
set hlsearch                " highlight all matches

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent       " fold based on indent level
set foldnestmax=10          " max 10 depth
set foldenable
set foldlevelstart=10       " open most folds by default

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
set encoding=utf8           " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac        " Use Unix as the standard file type
set bg=dark
colorscheme onedark         " Set colorscheme

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <space>j <C-W>j
map <space>k <C-W>k
map <space>h <C-W>h
map <space>l <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

map <Tab> :bnext<cr>
map <S-Tab> :bprevious<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\%{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

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
" nnoremap <leader>n :call VexToggle("")<cr>
" let g:netrw_banner = 0
" let g:netrw_liststyle=3
" let g:netrw_preview = 1
" let g:netrw_dirhistmax=0

" fun! VexToggle(dir)
"     if exists("t:vex_buf_nr")
"         call VexClose()
"     else
"         call VexOpen(a:dir)
"     endif
" endf

" fun! VexOpen(dir)
"     let g:netrw_browse_split=4 " open files in previous window
"     let vex_width = 25

"     execute "Vexplore " . a:dir
"     let t:vex_buf_nr = bufnr("%")
"     wincmd H

"     call VexSize(vex_width)
" endf

" fun! VexClose()
"     let cur_win_nr = winnr()
"     let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

"     1wincmd w
"     close
"     unlet t:vex_buf_nr

"     execute (target_nr - 1) . "wincmd w"
"     call NormalizeWidths()
" endf

" fun! VexSize(vex_width)
"     execute "vertical resize" . a:vex_width
"     set winfixwidth
"     call NormalizeWidths()
" endf

" fun! NormalizeWidths()
"     let eadir_pref = &eadirection
"     set eadirection=hor
"     set equalalways! equalalways!
"     let &eadirection = eadir_pref
" endf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>jsf :%!python -m json.tool<cr>
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" Close preview window after auto completion
autocmd CompleteDone * pclose

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
""""""""""""""""""""""""""""""""""""""""""""""""
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

function! <SID>CleanFile()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %!git stripspace
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete!".l:currentBufNum)
  endif
endfunction

