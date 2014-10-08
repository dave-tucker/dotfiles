#!/bin/bash

cd "$(dirname "$0")"

echo "   Installing Sublime Text 3 Preferences"

cp -R User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

echo "   Linking Sublime Text to ~/bin/subl"
mkdir -p ~/bin
ln -s -f "~/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
