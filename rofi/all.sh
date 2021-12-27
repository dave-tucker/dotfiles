#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/rofi
if [ ! -f ~/.config/rofi/config.rasi ]; then
    ln -s $(pwd)/config.rasi ~/.config/rofi/config.rasi
fi
