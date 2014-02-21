#!/bin/bash

cd "$(dirname "$0")"

echo "   Installing Sublime Text 2 Preferences"

cp -vf User/* "~/Library/Application Support/Sublime Text 2/User/"

echo "   Linking Sublime Text to ~/bin/subl"
ln -s "~/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
