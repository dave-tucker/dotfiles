#!/usr/bin/env bash

# mise v2026.4.11 - https://mise.jdx.dev
set -e

if ! command -v mise &>/dev/null; then
    curl https://mise.run | sh
fi

mise use --global go@1.26.2
mise use --global node@lts
mise use --global rust@stable
mise use --global aqua:starship/starship
mise use --global aqua:astral-sh/uv
mise use --global aqua:tree-sitter/tree-sitter
mise use --global npm:@mariozechner/pi-coding-agent@0.67.2
