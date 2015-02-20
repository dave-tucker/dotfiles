#!/bin/bash

set -e
cd "$(dirname "$0")"

if [ ! -d "$HOME/.zprezto" ]; then
echo "   Installing Oh My ZShell!"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "   Changing Default Shell to ZSH"
chsh -s /bin/zsh

echo "   Fixing Shell Colors"
sh base16-ocean.dark.sh
