#! /bin/bash

# bash
cp bashrc ~/.bashrc

# vim
VIM_CFG_DIR="$HOME/.vim"

cp vimrc ~/.vimrc
if [ ! -d $VIM_CFG_DIR ]; then
    mkdir $VIM_CFG_DIR
fi
cp vim/* "$VIM_CFG_DIR/" -rf

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# gdbinit
cp gdbinit ~/.gdbinit

# screen
cp screenrc ~/.screenrc

# ctags : add support for indexing .go files
cp ctags ~/.ctags

# tmux config
cp tmux.conf ~/.tmux.conf

# git config
cp gitconfig ~/.gitconfig
