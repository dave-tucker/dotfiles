#/bin/bash

set -e
cd "$(dirname "$0")"

mkdir -p ~/.config/terminator/
cp base16-ocean.dark.config ~/.config/terminator/config