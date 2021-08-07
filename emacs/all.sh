#!/bin/bash

set -e

cd $(dirname $0)

# Install spacemacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
