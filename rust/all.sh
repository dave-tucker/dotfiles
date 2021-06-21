#!/bin/bash

set -e

cd $(dirname $0)

if ! $(command -v rustup &> /dev/null); then
    curl -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
fi
