call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'sjl/gundo.vim'
Plug 'othree/es.next.syntax.vim'
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

call plug#end()
