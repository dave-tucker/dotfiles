#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

# find generic installers and run them interactively
find . -name all.sh | while read installer ; do sh -c "${installer}" > /dev/null ; done

# find os-specific installers and run them interactively
platform="unknown"
if [[ "$(uname)" == "Darwin" ]]; then
   platform="osx"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
   platform="linux"
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
    platform="windows"
fi

find . -name $platform.sh | while read installer ; do sh -x "${installer}" > /dev/null ; done
