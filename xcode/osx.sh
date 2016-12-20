#!/bin/sh

curl -sSL -o Dracula.dvtcolortheme https://raw.githubusercontent.com/dracula/xcode/master/Dracula.dvtcolortheme
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
ln -s "$(pwd)/Dracula.dvtcolortheme" ~/Library/Developer/Xcode/UserData/FontAndColorThemes/Dracula.dvtcolortheme
