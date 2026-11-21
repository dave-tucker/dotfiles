# dotfiles

Personal and work-machine configuration for macOS and Fedora, managed with [chezmoi](https://chezmoi.io) and [mise](https://mise.jdx.dev).

The repository manages shell, editor, terminal, Git, development tools, system packages, macOS applications, Pi, agent skills, scheduled updates, and work-only services.

## Prerequisites

- **macOS:** Xcode Command Line Tools and chezmoi
- **Fedora:** chezmoi

## Install

```sh
chezmoi init --apply dave-tucker/dotfiles
```

The first initialization asks for a machine role:

- `personal`
- `work`

Shared mise configuration is stored under `~/.config/mise/conf.d`. Work and personal packages are selected from `30-work.toml` and `40-personal.toml` respectively.

## Work-machine setup

### Mail sync

```sh
~/.config/work-mail-sync/authorize --authorize-thunderbird
chezmoi apply
```

### Work assistant

```sh
export OPENAI_API_KEY=...
setup-work-assistant
unset OPENAI_API_KEY
```

Run `setup-work-assistant` again after changing its image, driver, mounts, or sandbox configuration.

## Common commands

```sh
# Pull repository changes and apply them
chezmoi update

# Apply local source changes
chezmoi apply

# Preview destination changes
chezmoi diff

# Edit a managed file
chezmoi edit ~/.config/fish/config.fish

# Check managed package state
mise bootstrap packages status

# Update globally installed agent skills
just update-skills
```

## Repository development

```sh
# Install the repository's pre-commit hook
just hooks

# Run all static checks
just lint
```

The lint task checks JSON, YAML, TOML, shell scripts, GitHub Actions workflows, pinned action references, formatting, and systemd user units.

## Automatic updates

Each machine checks for merged dotfile changes every six hours:

- macOS uses `local.chezmoi-update` in `~/Library/LaunchAgents`.
- Linux uses `chezmoi-update.timer` as a systemd user timer.

The updater skips dirty source repositories and logs failures to:

- macOS: `~/Library/Logs/chezmoi-update.log`
- Linux: the systemd user journal

Global agent skills are refreshed at most once every seven days. GitHub Actions opens reviewed pull requests for pinned mise tool updates, and Dependabot updates pinned GitHub Actions revisions.

## License

Copyright 2014-2026 Dave Tucker. Licensed under the MIT License.
