#!/bin/bash

set -e
cd "$(dirname "$0")"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
echo "   Installing Oh My ZShell!"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

#echo "   Changing Default Shell to ZSH"
#chsh -s /bin/zsh

echo "   Fixing Shell Colors"
sh base16-ocean.dark.sh
