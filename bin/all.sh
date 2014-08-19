#!/bin/bash

set -e

cd "$(dirname $0)"

mkdir -p ~/bin
find . -not -name "all.sh" -exec cp {} ~/bin/ \;
