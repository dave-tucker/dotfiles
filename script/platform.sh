#!/bin/sh
#
# Run all dotfiles installers.

set -e

# find mac installers and run them interactively
platform="unknown"
if [ "$(uname -s)" = "Darwin" ]; then
   platform="osx"
elif [ "$(uname -s)" = "Linux" ]; then
   platform="linux"
elif [ "$(uname -s)" = "MINGW32_NT" ]; then
    platform="windows"
fi

find . -name $platform.sh | while read installer ; do sh -x "${installer}" > /dev/null ; done

