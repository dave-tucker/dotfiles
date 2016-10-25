#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

#set -e

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

cd "$(dirname "$0")"

# homebrew packages

TAPS=(
    homebrew/binary
    homebrew/dupes
    homebrew/versions
    caskroom/cask
    caskroom/versions
)

FORMULAS=(
    autoconf
    automake
    caskroom/cask/brew-cask
    coreutils
    ctags
    gimme
    mercurial
    pkg-config
    python
    python3
)

CASKS=(
    alfred
    arduino
    audio-hijack
    bartender
    caffeine
    choosy
    dash
    dropbox
    fantastical
    firefox
    fluid
    flux
    gpgtools
    hazel
    istat-menus
    iterm2
    keyboard-maestro
    1password
    osxfuse
    screenflow
    sketch
    skype
    spotify
    textexpander
    the-unarchiver
    xquartz
)

for tap in ${TAPS[@]}
do
    brew tap $tap
done

brew install ${FORMULAS[@]}

brew update

brew cask install ${CASKS[@]}

brew cask alfred link

# Special cases that need flags...
brew install vim --with-lua

brew cleanup

exit 0
