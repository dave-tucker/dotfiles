#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.config/systemd/user

for path in $(find . -type f ! -name all.sh); do
    path="$(pwd)/$path"
    dest=~/.config/systemd/user/`basename $path`
    if [ ! -f "$dest" ]; then
        ln -s $path $dest
    fi
done
