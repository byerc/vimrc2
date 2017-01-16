#!/usr/bin/env bash
cd ~/.vim

echo 'source ~/.vim/vimrcs/main.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/plugins.vim' > ~/.vimrc

echo "Installed vim configuration successfully."
