#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

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
    android-sdk
    ant
    autoconf
    automake
    boot2docker
    caskroom/cask/brew-cask
    coreutils
    docker
    erlang
    go
    grc
    homebrew/versions/maven30
    memcached
    mercurial
    packer
    pkg-config
    pyenv
    python
    python3
    rbenv
    ruby-build
    sbt
    scala
    spark
)

CASKS=(
    alfred
    arduino
    audio-hijack-pro
    bartender
    bettertouchtool
    caffeine
    choosy
    dash
    devonthink-pro
    dropbox
    fantastical
    firefox
    fluid
    flux
    gimp
    google-chrome
    google-drive
    google-hangouts
    gpgtools
    graphsketcher
    hazel
    induction
    intellij-idea-community-eap
    istat-menus
    iterm2
    keyboard-maestro
    mailmate
    marked
    node
    nvalt
    omnigraffle
    omnioutliner
    omnipresence
    onepassword
    osxfuse
    p4merge
    pandoc
    postgres
    rdm
    robomongo
    screenflow
    scrivener
    sequel-pro
    sketch
    skype
    sourcetree
    spotify
    sublime-text3
    textexpander
    the-unarchiver
    tower
    transmit
    ubersicht
    utorrent
    vagrant
    virtualbox
    visualvm
    vlc
    wireshark
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

brew cleanup

exit 0
