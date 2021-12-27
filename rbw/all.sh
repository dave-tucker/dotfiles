#!/bin/sh

set -e

cd $(dirname $0)

if [ ! $(command -v rbw) ]; then
    cargo install rbw
    rbw config set email dave@dtucker.co.uk
    rbw register
fi
