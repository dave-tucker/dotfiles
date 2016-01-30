#!/bin/bash

cd "$(dirname "$0")"

echo "   Installing Sublime Text 3 Preferences"

mkdir -p ~/.config/sublime-text-3/Packages/User/
cp -v User/* ~/.config/sublime-text-3/Packages/User/
