#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

work_data='{"is_work":true,"machine_role":"work","work_mail_address":"worker@example.com","vertex_project_id":"test-project","vertex_region":"global"}'
personal_data='{"is_work":false,"machine_role":"personal"}'

render() {
  local data=$1 source=$2 destination=$3
  chezmoi execute-template --source "$repo_root" --override-data "$data" < "$source" > "$destination"
}

# Validate the generated chezmoi configuration for both roles.
for role in work personal; do
  args=(--source "$repo_root" --init --no-tty)
  if [[ $role == work ]]; then
    args+=(
      --promptString 'Machine role (personal/work)=work'
      --promptString 'Work email address=worker@example.com'
      --promptString 'Vertex Project ID=test-project'
      --promptString 'Vertex Region=global'
    )
  else
    args+=(--promptString 'Machine role (personal/work)=personal')
  fi
  chezmoi execute-template "${args[@]}" < .chezmoi.toml.tmpl > "$tmp/chezmoi-$role.toml"
done

python3 - "$tmp" <<'PY'
import json
import pathlib
import plistlib
import sys
import tomllib

root = pathlib.Path.cwd()
tmp = pathlib.Path(sys.argv[1])

for path in root.rglob("*.toml"):
    if ".git" not in path.parts:
        with path.open("rb") as file:
            tomllib.load(file)

for path in tmp.glob("*.toml"):
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

# Validate role-specific JSON and TOML templates.
for role in work personal; do
  if [[ $role == work ]]; then data=$work_data; else data=$personal_data; fi
  render "$data" dot_pi/agent/settings.json.tmpl "$tmp/settings-$role.json"
  render "$data" dot_pi/agent/mcp.json.tmpl "$tmp/mcp-$role.json"
  jq empty "$tmp/settings-$role.json" "$tmp/mcp-$role.json"
  prettier --check "$tmp/settings-$role.json" "$tmp/mcp-$role.json"
done

render "$work_data" dot_config/work-assistant/driver.json.tmpl "$tmp/driver.json"
render "$work_data" dot_config/work-assistant/himalaya.toml.tmpl "$tmp/himalaya.toml"
render "$work_data" Library/LaunchAgents/local.work-mail-sync.plist.tmpl "$tmp/work-mail.plist"
render "$work_data" Library/LaunchAgents/local.chezmoi-update.plist.tmpl "$tmp/chezmoi-update.plist"
jq empty "$tmp/driver.json"
prettier --check "$tmp/driver.json"
python3 - "$tmp/himalaya.toml" "$tmp/work-mail.plist" "$tmp/chezmoi-update.plist" <<'PY'
import plistlib
import sys
import tomllib

with open(sys.argv[1], "rb") as file:
    tomllib.load(file)
for path in sys.argv[2:]:
    with open(path, "rb") as file:
        plistlib.load(file)
PY

# Render shell templates before linting them.
render "$work_data" run_once_install_fonts.sh.tmpl "$tmp/install-fonts.sh"
render "$work_data" run_onchange_after_20-mise-bootstrap.sh.tmpl "$tmp/mise-bootstrap.sh"
render "$work_data" run_onchange_after_30-work-apps.sh.tmpl "$tmp/work-apps.sh"
render "$work_data" run_onchange_after_40-chezmoi-update-service.sh.tmpl "$tmp/chezmoi-update-service.sh"

shell_files=(
  dot_config/work-mail-sync/executable_authorize
  dot_local/bin/executable_proj
  dot_local/bin/executable_setup-work-assistant
  dot_local/bin/executable_sync-work-mail
  dot_local/bin/executable_update-dotfiles
  run_once_before_10-install-mise.sh
  run_once_install_tpm.sh
  "$tmp/install-fonts.sh"
  "$tmp/mise-bootstrap.sh"
  "$tmp/work-apps.sh"
  "$tmp/chezmoi-update-service.sh"
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
  systemd-analyze --user verify \
    dot_config/systemd/user/chezmoi-update.service \
    dot_config/systemd/user/chezmoi-update.timer
fi

echo "lint: ok"
