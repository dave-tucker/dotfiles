#!/bin/sh

set -e

cd $(dirname $0)

# Vivaldi
sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo

# VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
sudo dnf config-manager --add-repo ./vscodium.repo

# i3lock-color
sudo dnf -y copr enable tokariew/i3lock-color
sudo dnf remove i3lock

# spotify-tui
sudo dnf -y copr enable atim/spotify-tui

# Install packages
xargs sudo dnf -y install < packages.txt
