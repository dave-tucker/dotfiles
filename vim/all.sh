#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -d ~/.cache/dein ]; then
    mkdir -p ~/.cache
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein
    rm ./installer.sh
fi

mkdir -p ~/.config/nvim
if [ ! -f ~/.config/nvim/init.vim ]; then
    ln -s $(pwd)/init.vim ~/.config/nvim/init.vim
fi