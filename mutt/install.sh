#!/bin/sh

set -e

cd $(dirname $0)

mkdir -p ~/.mutt
for path in $(find . -type f ! -name all.sh); do
    path="$(pwd)/$path"
    dest=~/.mutt/`basename $path`
    if [ ! -f "$dest" ]; then
        ln -s $path $dest
    fi
done
