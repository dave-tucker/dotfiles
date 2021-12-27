#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -d ~/.config/i3 ]; then
	ln -s $(pwd)/i3 ~/.config/i3
fi

if [ ! -d ~/.config/i3status-rust ]; then
	ln -s $(pwd)/i3status-rust ~/.config/i3status-rust
fi

if [ ! -d ~/.local/share/i3status-rust ]; then
	ln -s $(pwd)/share/i3status-rust ~/.local/share/i3status-rust
fi

if [ ! -f ~/.local/bin/betterlockscreen ]; then
	wget https://git.io/JZyxV -O - -q | bash -- user main
fi

if [ ! -f ~/.config/betterlockscreenrc ]; then
	ln -s $(pwd)/betterlockscreenrc ~/.config/betterlockscreenrc
fi

betterlockscreen -u ~/.desktop/wallpaper.png
