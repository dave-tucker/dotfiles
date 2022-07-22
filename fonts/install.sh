#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -f FiraCode.zip ]; then
	curl -f -o FiraCode.zip -sSL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
fi

mkdir -p ~/.fonts
unzip -u -d ~/.fonts FiraCode.zip
fc-cache -v
