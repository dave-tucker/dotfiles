#!/bin/sh

set -e

cd $(dirname $0)

# FIXME: Package this. Or do a cargo install
# Can wait until v0.3.4 is released and/or on crates.io

mkdir -p ~/.config/spotifyd
if [ ! -f ~/.config/spotifyd/spotifyd.conf ]; then
    ln -s $(pwd)/spotifyd.conf ~/.config/spotifyd/spotifyd.conf
fi
