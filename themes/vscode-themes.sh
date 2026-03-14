#!/usr/bin/env zsh

[[ -z "$VSC_THEME" ]] && { echo "  vscode: VSC_THEME not set, skipping"; return; }
[[ -z "$VSC_EXTENSION" ]] && { echo "  vscode: VSC_EXTENSION not set, skipping"; return; }

SETTINGS="$HOME/.config/Code/User/settings.json"
[[ -f "$SETTINGS" ]] || { echo "  vscode: settings.json not found, skipping"; return; }

code --install-extension "$VSC_EXTENSION" --force 2>/dev/null || true

python3 - "$SETTINGS" "$VSC_THEME" << 'PYEOF'
import json, sys
path, theme = sys.argv[1], sys.argv[2]
with open(path) as f:
    data = json.load(f)
data["workbench.colorTheme"] = theme
with open(path, "w") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
PYEOF

echo "  ✓ vscode ($VSC_THEME)"
