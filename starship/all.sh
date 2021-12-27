#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config
if [ ! -f ~/.config/starship.toml ]; then
    ln -s $(pwd)/starship.toml ~/.config/starship.toml
fi
