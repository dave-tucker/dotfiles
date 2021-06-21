#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/kitty
cp *.conf ~/.config/kitty
