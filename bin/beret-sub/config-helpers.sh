#!/usr/bin/env zsh
# config-helpers.sh — safe configuration file manipulation helpers
# Provides robust alternatives to sed for JSON and TOML edits.

# Usage: beret_vscode_set_setting <key> <value>
#   key: dotted JSON key, e.g. "editor.fontSize"
#   value: raw JSON value, e.g. "14" or "\"JetBrains Mono\""
beret_vscode_set_setting() {
  local key="$1"
  local value="$2"
  local settings_file="$HOME/.config/Code/User/settings.json"

  if [[ ! -f "$settings_file" ]]; then
    return 0
  fi

  # Backup before any mutation
  local backup="${settings_file}.beret-backup.$(date +%s)"
  cp "$settings_file" "$backup" 2>/dev/null || true

  # Validate JSON before editing
  if ! python3 -m json.tool "$settings_file" >/dev/null 2>&1; then
    echo "⚠ Warning: $settings_file is not valid JSON. Skipping VS Code $key update." >&2
    return 1
  fi

  # Build a small Python snippet that mutates the setting safely
  python3 - "$settings_file" "$key" "$value" << 'PYEOF'
import json, sys, os

settings_path = sys.argv[1]
key = sys.argv[2]
value_raw = sys.argv[3]

try:
    with open(settings_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
except Exception as e:
    print(f"Failed to read settings: {e}", file=sys.stderr)
    sys.exit(1)

# Support dotted keys like "terminal.integrated.fontSize"
keys = key.split('.')
node = data
for k in keys[:-1]:
    if k not in node or not isinstance(node[k], dict):
        node[k] = {}
    node = node[k]

# Parse value as JSON if possible, otherwise keep string
try:
    parsed_value = json.loads(value_raw)
except json.JSONDecodeError:
    parsed_value = value_raw

node[keys[-1]] = parsed_value

try:
    with open(settings_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)
        f.write('\n')
except Exception as e:
    print(f"Failed to write settings: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF

  local py_exit=$?
  if [[ $py_exit -ne 0 ]]; then
    # Restore backup on failure
    if [[ -f "$backup" ]]; then
      mv "$backup" "$settings_file"
    fi
    return 1
  fi

  # Clean up backup on success
  rm -f "$backup"
  return 0
}

# Usage: beret_alacritty_set_font_size <size>
beret_alacritty_set_font_size() {
  local size="$1"
  local target="$HOME/.config/alacritty/font-size.toml"

  if [[ ! -f "$target" ]]; then
    echo "⚠ Warning: $target not found. Creating default font-size.toml." >&2
    mkdir -p "$(dirname "$target")"
    cat > "$target" << 'EOF'
# Leave this file in place for beret to rely on a shared font size for all terminal apps
[font]
size = 9
EOF
  fi

  # Backup before mutation
  local backup="${target}.beret-backup.$(date +%s)"
  cp "$target" "$backup" 2>/dev/null || true

  # Robust sed: match "size = <number>" inside [font] section, tolerating whitespace
  if grep -q '^\s*size\s*=\s*[0-9]\+' "$target"; then
    sed -i -E "s/^([[:space:]]*)size[[:space:]]*=[[:space:]]*[0-9]+/\1size = ${size}/" "$target"
  else
    # If no size line exists, append under [font]
    sed -i "/^\[font\]/a size = ${size}" "$target"
  fi

  if grep -q "^\s*size\s*=\s*${size}\s*\$" "$target"; then
    rm -f "$backup"
    return 0
  else
    echo "⚠ Warning: Failed to update font size in $target. Restoring backup." >&2
    mv "$backup" "$target"
    return 1
  fi
}

# Usage: beret_alacritty_set_font <font_config_file>
beret_alacritty_set_font() {
  local src="$1"
  local target="$HOME/.config/alacritty/font.toml"

  if [[ ! -f "$src" ]]; then
    echo "⚠ Warning: Font config $src not found." >&2
    return 1
  fi

  mkdir -p "$(dirname "$target")"
  cp "$src" "$target"
}
