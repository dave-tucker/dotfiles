#!/bin/sh

cd "$(dirname "$0")"

echo "  Installing iTerm2 Colors."
/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Base16 Ocean Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'iTerm2/base16-ocean.dark.itermcolors' :'Custom Color Presets':'Solarized Light'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Base16 Ocean Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'iTerm2/base16-ocean.light.itermcolors' :'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist

