#!/bin/sh

set -e

cd $(dirname $0)

# Add FlatHub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

xargs sudo flatpak -y install < packages.txt
