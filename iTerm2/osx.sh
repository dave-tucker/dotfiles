#!/bin/sh

cd "$(dirname "$0")" || exit 1

echo "  Installing iTerm2 Colors."

curl -sSL -o Dracula.itermcolors https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors

#ToDo: Should probably find a better way of doing this
killall cfprefsd

/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Dracula' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'Dracula.itermcolors' :'Custom Color Presets':'Dracula'" ~/Library/Preferences/com.googlecode.iterm2.plist

#ToDo: Add fonts
#
# Key = "New Bookmarks"
#
#"Non Ascii Font" = "UbuntuMonoDerivativePowerline-Regular 16";
#"Non-ASCII Anti Aliased" = 1;
#"Normal Font" = "UbuntuMonoDerivativePowerline-Regular 16";
