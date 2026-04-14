# dotfiles

Managed with [chezmoi](https://chezmoi.io).

## What's managed

| Tool | Config |
|---|---|
| [fish](https://fishshell.com) | `~/.config/fish/` |
| [starship](https://starship.rs) | `~/.config/starship/starship.toml` |
| [ghostty](https://ghostty.org) | `~/.config/ghostty/config` |
| [neovim](https://neovim.io) | `~/.config/nvim/` |
| [tmux](https://github.com/tmux/tmux) + [TPM](https://github.com/tmux-plugins/tpm) | `~/.tmux.conf` |
| [git](https://git-scm.com) | `~/.gitconfig` |
| [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts) | installed everywhere |
| [Rust](https://www.rust-lang.org) + [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter) | via mise |
| [Go](https://go.dev) | via mise |
| [uv](https://github.com/astral-sh/uv) | via mise |
| [Node.js](https://nodejs.org) | via mise (lts) |
| [pi-coding-agent](https://github.com/mariozechner/pi-coding-agent) | via mise npm tool |

## Prerequisites

Install these before running chezmoi. Use your system package manager:

- `fish`
- `tmux`
- `neovim`
- `ghostty`
- `git` + `git-lfs`
- `gh` (GitHub CLI)
- `chezmoi`
- `zoxide`, `fzf`, `ripgrep`, `fd`
- `gh`, `git-lfs` (Fedora RPMs)

## Bootstrap

```sh
chezmoi init --apply dave-tucker/dotfiles
```

## Daily use

```sh
# Pull latest and apply
chezmoi update

# Edit a managed file
chezmoi edit ~/.config/fish/config.fish

# See what would change
chezmoi diff
```

## License

Copyright 2014-2026 Dave Tucker. Licensed under the MIT License.
