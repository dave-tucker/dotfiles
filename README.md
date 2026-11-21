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
| [pi-coding-agent](https://github.com/mariozechner/pi-coding-agent) | via mise npm tool, with work/personal provider defaults |
| System packages and macOS apps | via mise bootstrap packages |
| Work assistant and mail sync | work machines only, via OpenShell and Podman |

## Machine roles

The first `chezmoi init` asks whether the machine is `personal` or `work`. The answer is stored only in the machine's local chezmoi config. Shared tools live in the common mise fragments; role-specific packages live in `30-work.toml` and `40-personal.toml`. Work-only configuration, images, services, and LaunchAgents are not applied to personal machines.

## Prerequisites

- **macOS**: Xcode CLI tools and chezmoi
- **Fedora**: chezmoi

Chezmoi installs mise. Mise then installs the declared tools and system packages. Tool versions are pinned exactly; a weekly GitHub Actions workflow opens reviewed update PRs for newer releases.

## Bootstrap

```sh
chezmoi init --apply dave-tucker/dotfiles
```

## Work-machine setup

After the first apply, authorize mail sync:

```sh
~/.config/work-mail-sync/authorize --authorize-thunderbird
chezmoi apply
```

Create the OpenShell work assistant without putting the API key in chezmoi:

```sh
export OPENAI_API_KEY=...
setup-work-assistant
unset OPENAI_API_KEY
```

Running `setup-work-assistant` again updates the sandbox policy. Image, mount, or driver changes require explicitly recreating the sandbox so chezmoi never destroys a working sandbox automatically.

## Daily use

```sh
# Pull latest and apply
chezmoi update

# Edit a managed file
chezmoi edit ~/.config/fish/config.fish

# See what would change
chezmoi diff

# Check package drift
mise bootstrap packages status

# Install the source repository's commit hook (once per clone)
just hooks

# Run static repository checks
just lint
```

## Automated updates

GitHub Actions checks weekly for tool releases that are at least seven days old and opens a signed-off pull request with updated exact pins. Action dependencies are pinned to full commit SHAs and updated by Dependabot. A pre-commit hook runs the same `just lint` command as CI, validating the repository with actionlint, yamllint, jq, yq, Prettier, taplo, shellcheck, and shfmt.

Each machine checks for merged dotfile changes every six hours:

- macOS uses `local.chezmoi-update` in `~/Library/LaunchAgents`.
- Linux uses the `chezmoi-update.timer` systemd user timer.

The updater refuses to run when the chezmoi source repository is dirty and never forces destination changes. Failures are logged to `~/Library/Logs/chezmoi-update.log` on macOS or the systemd user journal on Linux.

Chezmoi auto-adds, commits, and pushes after chezmoi changes its source state; it is not a watcher for direct edits made inside the source directory.

## License

Copyright 2014-2026 Dave Tucker. Licensed under the MIT License.
