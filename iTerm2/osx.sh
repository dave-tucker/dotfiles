#!/bin/sh

cd "$(dirname "$0")"

echo "  Installing iTerm2 Colors."

#ToDo: Should probably find a better way of doing this
# killall cfprefsd is a big hammer. defaults write would be preferred.

/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Base16 Ocean Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'base16-ocean.dark.itermcolors' :'Custom Color Presets':'Base16 Ocean Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Base16 Ocean Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'base16-ocean.light.itermcolors' :'Custom Color Presets':'Base16 Ocean Light'" ~/Library/Preferences/com.googlecode.iterm2.plist

#ToDo: Add fonts
#
# Key = "New Bookmarks"
#
#"Non Ascii Font" = "UbuntuMonoDerivativePowerline-Regular 16";
#"Non-ASCII Anti Aliased" = 1;
#"Normal Font" = "UbuntuMonoDerivativePowerline-Regular 16";

killall cfprefsd
