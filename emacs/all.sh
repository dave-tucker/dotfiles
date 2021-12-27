#!/bin/bash

set -e

cd $(dirname $0)

# Install doom-emacs
if [ ! -d ~/.emacs.d ]; then
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
	~/.emacs.d/bin/doom install
fi
