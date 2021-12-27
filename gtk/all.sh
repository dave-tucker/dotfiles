#!/bin/sh

set -e

cd $(dirname $0)

if [ ! -f Dracula.zip ]; then
	curl -f -o Dracula.zip -sSL https://github.com/dracula/gtk/archive/master.zip
fi

mkdir -p ~/.themes
if [ ! -d ~/.themes/Dracula ]; then
	unzip -u -d ~/.themes Dracula.zip
	mv ~/.themes/gtk-master ~/.themes/Dracula
fi

if [ ! -f DraculaIcons.zip ]; then
	curl -f -o DraculaIcons.zip -sSL https://github.com/dracula/gtk/files/5214870/Dracula.zip
fi

mkdir -p ~/.icons
if [ ! -d ~/.icons/Dracula ]; then
	unzip -u -d ~/.icons DraculaIcons.zip
fi

mkdir -p ~/.config/gtk-3.0
if [ ! -f ~/.config/gtk-3.0/settings.ini ]; then
	ln -s $(pwd)/settings.ini ~/.config/gtk-3.0/settings.ini
fi
