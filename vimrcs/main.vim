
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'jlanzarotta/bufexplorer'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'moll/vim-node'
Plug 'sjl/gundo.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'honza/vim-snippets'
Plug 'othree/yajs.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'digitaltoad/vim-pug'
Plug 'mustache/vim-mustache-handlebars'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --tern-completer' } 
Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'jungomi/vim-mdnquery'
Plug 'Raimondi/delimitMate'

call plug#end()

set clipboard=unnamed

try
    source ~/.vim/vimrcs/plugins_config.vim
catch
endtry

set bg=dark
colorscheme onedark         " Set colorscheme

set ttyfast                 " faster redraw

set backspace=indent,eol,start
set whichwrap+=<,>,h,l

set lazyredraw              " Don't redraw while executing macros (good performance config)

"""""""""""""""""""""""
" => Spaces and Tabs
"""""""""""""""""""""""
set tabstop=4               " number of visual spaces per TAB
set expandtab               " tabs are spaces
set smarttab
set softtabstop=4           " number of spaces in tab when editing
set shiftwidth=4

set modelines=1

set autoindent              " indent when creating new line
set number                  " show line numbers
set showcmd                 " show command in bottom bar
set nocursorline            " highlight current line
set wildmenu                " deals with autocomplete on the command line. See ':help wildmenu'
set showmatch               " higlight matching parenthesis
set ignorecase              " ignore case when searching
set incsearch               " search as characters are entered
set hlsearch                " highlight all matches
set foldmethod=indent       " fold based on indent level
set foldnestmax=10          " max 10 depth
set foldenable
set foldlevelstart=10       " open most folds by default
set list                    " show whitespace
set listchars+=space:.

""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""
" => The Silver Searcher
"""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  " nnoremap \ :Ag<SPACE>
  map <leader>g :Ag 
endif


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

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
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

