#!/bin/sh

cd "$(dirname "$0")"

echo "  Installing IntelliJ Colors"
mkdir -p ~/Library/Application\ Support/IdeaIC13/colors
cp *.icls ~/Library/Application\ Support/IdeaIC13/colors
