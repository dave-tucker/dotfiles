#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -d ~/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

mkdir -p ~/.config/nvim
if [ ! -f ~/.config/nvim/init.vim ]; then
    ln -s $(pwd)/init.vim ~/.config/nvim/init.vim
fi
