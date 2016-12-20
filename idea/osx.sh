#!/bin/sh

cd "$(dirname "$0")" || exit 1

curl -sSL -o Dracula.icls https://raw.githubusercontent.com/dracula/jetbrains/master/Dracula.icls

echo "  Installing IntelliJ Colors"
find . -name \*.icls -exec cp {} ~/Library/Preferences/IdeaIC13/colors \;
