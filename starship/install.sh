#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -f /usr/local/bin/starship ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

mkdir -p ~/.config
if [ ! -f ~/.config/starship.toml ]; then
    ln -s $(pwd)/starship.toml ~/.config/starship.toml
fi
