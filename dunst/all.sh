#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/dunst
if [ ! -f ~/.config/dunst/dunstrc ]; then
    ln -s $(pwd)/dunstrc ~/.config/dunst/dunstrc
fi
