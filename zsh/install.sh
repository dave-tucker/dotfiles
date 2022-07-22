#!/bin/bash

set -e
cd "$(dirname "$0")"

if [ ! -d "$HOME/.zsh_antigen" ]; then
echo "   Installing Antigen!"
git clone https://github.com/zsh-users/antigen.git ~/.zsh_antigen
fi
