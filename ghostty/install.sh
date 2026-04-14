#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/ghostty
if [ ! -f ~/.config/ghostty/config.ghostty ]; then
  ln -s $(pwd)/config.ghostty ~/.config/ghostty/config.ghostty
fi
