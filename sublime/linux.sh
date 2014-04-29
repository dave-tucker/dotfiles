#!/bin/bash

cd "$(dirname "$0")"

echo "   Installing Sublime Text 2 Preferences"

cp -v User/* ~/.config/sublime-text-2/Packages/User/
