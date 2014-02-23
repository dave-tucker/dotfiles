#!/bin/bash

set -e
cd "$(dirname "$0")"

echo "   Installing Pyhton Packages"

pip install -r requirements.txt
