#!/bin/bash
 
cd "$(dirname "$0")"

echo "   Installing Fonts"

mkdir -p ~/.fonts
cp -f *.ttf ~/.fonts
fc-cache -v

