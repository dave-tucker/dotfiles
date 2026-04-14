#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/nvim
if [ ! -f ~/.config/nvim/init.lua ]; then
    git clone https://github.com/dave-tucker/kickstart.nvim ~/.config/nvim
fi
