#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

python3 <<'PY'
import json
import pathlib
import tomllib

root = pathlib.Path.cwd()
for path in root.rglob("*.toml"):
    if ".git" not in path.parts:
        with path.open("rb") as file:
            tomllib.load(file)
for path in root.rglob("*.json"):
    if ".git" not in path.parts:
        json.loads(path.read_text())
json.loads((root / "dot_config/work-assistant/sandbox-policy.yaml").read_text())
PY

while IFS= read -r -d '' json_file; do
  jq empty "$json_file"
  if [[ $json_file != dot_config/nvim/lazy-lock.json ]]; then
    prettier --check "$json_file"
  fi
done < <(git ls-files -z -- '*.json')

while IFS= read -r -d '' yaml_file; do
  yamllint -c .yamllint.yaml --strict "$yaml_file"
  yq eval '.' "$yaml_file" >/dev/null
done < <(git ls-files -z -- '*.yaml' '*.yml')

while IFS= read -r -d '' toml_file; do
  taplo fmt --check "$toml_file"
done < <(git ls-files -z -- '*.toml')

shell_files=(
  dot_config/work-mail-sync/executable_authorize
  dot_local/bin/executable_proj
  dot_local/bin/executable_setup-work-assistant
  dot_local/bin/executable_sync-work-mail
  dot_local/bin/executable_update-dotfiles
  run_once_before_10-install-mise.sh
  run_once_install_tpm.sh
  scripts/lint.sh
)

shellcheck "${shell_files[@]}"
shfmt -d -i 2 -ci "${shell_files[@]}"
actionlint

python3 <<'PY'
import pathlib
import re

sha = re.compile(r"^[0-9a-f]{40}$")
uses = re.compile(r"^\s*-?\s*uses:\s*([^#\s]+)")
errors = []
for workflow in pathlib.Path(".github/workflows").glob("*.y*ml"):
    for number, line in enumerate(workflow.read_text().splitlines(), 1):
        match = uses.match(line)
        if not match:
            continue
        reference = match.group(1)
        if reference.startswith(("./", "docker://")):
            continue
        if "@" not in reference or not sha.fullmatch(reference.rsplit("@", 1)[1]):
            errors.append(f"{workflow}:{number}: action is not pinned to a full commit SHA: {reference}")
if errors:
    raise SystemExit("\n".join(errors))
PY

if command -v systemd-analyze >/dev/null 2>&1; then
  sed 's|^ExecStart=.*|ExecStart=/bin/true|' \
    dot_config/systemd/user/chezmoi-update.service >"$tmp/chezmoi-update.service"
  cp dot_config/systemd/user/chezmoi-update.timer "$tmp/chezmoi-update.timer"
  systemd-analyze --user verify \
    "$tmp/chezmoi-update.service" \
    "$tmp/chezmoi-update.timer"
fi

echo "lint: ok"
