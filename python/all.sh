#!/bin/zsh

set -ex

cd $(dirname $0)

if [ ! -d ~/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

pyenv install -s 2.7.18
pyenv install -s 3.9.9

if [ ! -d ~/.pyenv/versions/neovim2 ]; then
	pyenv virtualenv 2.7.18 neovim2
fi

if [ ! -d ~/.pyenv/versions/neovim3 ]; then
	pyenv virtualenv 3.9.9 neovim3
fi

eval "$(pyenv virtualenv-init -)"

pyenv activate neovim2
pip install neovim

pyenv activate neovim3
pip install neovim
