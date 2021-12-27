#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config
if [ ! -f ~/.config/picom.conf ]; then
    ln -s $(pwd)/picom.conf ~/.config/picom.conf
fi
