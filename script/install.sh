#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -name run_install.sh | while read installer ; do sh -c "${installer}" > /dev/null ; done
