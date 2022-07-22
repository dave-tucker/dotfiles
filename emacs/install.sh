#!/bin/bash

set -e

cd $(dirname $0)

# Install doom-emacs
if [ ! -d ~/.emacs.d ]; then
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
fi

# Need to run this from zshrc IF it's not already installed
#~/.emacs.d/bin/doom install
