#!/bin/sh

cd "$(dirname "$0")"

echo "  Installing IntelliJ Colors"
find . -name \*.icls -exec cp {} ~/Library/Preferences/IdeaIC13/colors \;
