#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/
if [ ! -d ~/.config/autorandr ]; then
    ln -s $(pwd)/autorandr ~/.config/autorandr
fi
