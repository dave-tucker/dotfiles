#!/usr/bin/env bash
set -euo pipefail

if ! command -v mise >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -fsSL https://mise.run | sh
fi
