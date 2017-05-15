"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

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

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

"""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = 'x'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '?'
let g:syntastic_style_warning_symbol = '?'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Syntastic local linter support
let g:syntastic_javascript_checkers = []
function CheckJavaScriptLinter(filepath, linter)
  if exists('b:syntastic_checkers')
    return
  endif
  if filereadable(a:filepath)
    let b:syntastic_checkers = [a:linter]
    let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
  endif
endfunction

function SetupJavaScriptLinter()
  let l:current_folder = expand('%:p:h')
  let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', l:current_folder), ':h')
  let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
  call CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
  call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
endfunction

autocmd FileType javascript call SetupJavaScriptLinter()

"""""""""""""""""""""""""""""""""
" => gundo
"""""""""""""""""""""""""""""""""
let g:gundo_prefer_python3 = 1

""""""""""""""""""""""""""""""""""
" => ctrlp
""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<leader>f' "ctrlp mapping
let g:ctrlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""""""
" => goyo
""""""""""""""""""""""""""""""""""
let g:goyo_width = 120
function! s:goyo_enter()
  colorscheme pencil
  highlight Normal ctermfg=black
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set nolist
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  colorscheme onedark
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set list
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
map <leader>go :Goyo<cr>

""""""""""""""""""""""""""""""""""
" => limelight
""""""""""""""""""""""""""""""""""
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
" let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1


""""""""""""""""""""""""""""""""""
" => youcompleteme
""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<ENTER>', '<TAB>', '<Down>']
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theme='solarized-dark'
