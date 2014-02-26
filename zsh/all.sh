#!/bin/bash

set -e

if [ ! -d "~/.oh-my-zsh" ]; then
    echo "   Installing Oh My ZShell!"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

echo "   Changing Default Shell to ZSH"
chsh -s /bin/zsh
