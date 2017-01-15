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

"""""""""""""""""""""""""""""""""
" => gundo
"""""""""""""""""""""""""""""""""
let g:gundo_prefer_python3 = 1

""""""""""""""""""""""""""""""""""
" => ctrlp
""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

""""""""""""""""""""""""""""""""""
" => goyo
""""""""""""""""""""""""""""""""""
let g:goyo_width = 120

""""""""""""""""""""""""""""""""""
" => youcompleteme
""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<Enter>', '<TAB>', '<Down>']
