#!/bin/bash

set -e
cd "$(dirname "$0")"

echo "   Installing Python Packages"

pip install -r requirements.txt
