<<<<<<< HEAD
#!/usr/bin/env bash
# beret-theme — switch the active theme across all supported apps
# Usage: beret-theme [theme-name]
#        beret-theme          (interactive picker)
=======
#!/usr/bin/env zsh
# berret-theme — switch the active theme across all supported apps
# Usage: berret-theme [theme-name]
#        berret-theme          (interactive picker)
>>>>>>> 2c65214 (Changes bash to zsh in scripts)

BERRET_DIR="$HOME/.local/share/beret"
THEMES_DIR="$BERRET_DIR/themes"
CURRENT_FILE="$BERRET_DIR/.current-theme"

SUPPORTED_THEMES=(
  catppuccin
  gruvbox
  kanagawa
  materia-black
  nordic
  osaka-jade
  rose-pine
  tokyo-night
)

# ── helpers ──────────────────────────────────────────────────────────────────

die() { echo "error: $*" >&2; exit 1; }

theme_exists() {
  local t="$1"
  for s in "${SUPPORTED_THEMES[@]}"; do
    [[ "$s" == "$t" ]] && return 0
  done
  return 1
}

pick_theme() {
  if command -v gum &>/dev/null; then
    gum choose "${SUPPORTED_THEMES[@]}"
  else
    echo "Available themes:"
    for i in "${!SUPPORTED_THEMES[@]}"; do
      printf "  %d) %s\n" "$((i+1))" "${SUPPORTED_THEMES[$i]}"
    done
    read -rp "Pick a number: " n
    echo "${SUPPORTED_THEMES[$((n-1))]}"
  fi
}

# ── appliers ─────────────────────────────────────────────────────────────────

apply_alacritty() {
  local theme="$1"
  local src="$THEMES_DIR/$theme/alacritty.toml"
  [[ -f "$src" ]] || { echo "  alacritty: no theme file, skipping"; return; }

  cp "$src" "$HOME/.config/alacritty/theme.toml"
  echo "  ✓ alacritty"
}

apply_btop() {
  local theme="$1"
  local src="$THEMES_DIR/$theme/btop.theme"
  [[ -f "$src" ]] || { echo "  btop: no theme file, skipping"; return; }

  local themes_dir="$HOME/.config/btop/themes"
  mkdir -p "$themes_dir"
  cp "$src" "$themes_dir/$theme.theme"

  # Update btop.conf to point at the new theme
  local conf="$HOME/.config/btop/btop.conf"
  if [[ -f "$conf" ]]; then
    sed -i "s|^color_theme = .*|color_theme = \"$theme\"|" "$conf"
  fi
  echo "  ✓ btop"
}

apply_neovim() {
  local theme="$1"
  local src="$THEMES_DIR/$theme/neovim.lua"
  [[ -f "$src" ]] || { echo "  neovim: no theme file, skipping"; return; }

  cp "$src" "$HOME/.config/nvim/lua/plugins/theme.lua"
  echo "  ✓ neovim (restart nvim to apply)"
}

apply_zellij() {
  local theme="$1"
  local src="$THEMES_DIR/$theme/zellij.kdl"
  [[ -f "$src" ]] || { echo "  zellij: no theme file, skipping"; return; }

  local themes_dir="$HOME/.config/zellij/themes"
  mkdir -p "$themes_dir"
  cp "$src" "$themes_dir/$theme.kdl"

  # Update config.kdl theme line
  local conf="$HOME/.config/zellij/config.kdl"
  if [[ -f "$conf" ]]; then
    if grep -q '^theme ' "$conf"; then
      sed -i "s|^theme .*|theme \"$theme\"|" "$conf"
    else
      echo "theme \"$theme\"" >> "$conf"
    fi
  fi
  echo "  ✓ zellij (new sessions will use the theme)"
}

apply_vscode() {
  local theme="$1"
  local settings="$HOME/.config/Code/User/settings.json"
  [[ -f "$settings" ]] || { echo "  vscode: settings.json not found, skipping"; return; }

  declare -A VSCODE_MAP=(
    [tokyo-night]="Tokyo Night Storm"
    [catppuccin]="Catppuccin Mocha"
    [gruvbox]="Gruvbox Dark Hard"
    [rose-pine]="Rosé Pine"
    [kanagawa]="Kanagawa Wave"
    [nordic]="Nord"
    [osaka-jade]="Tokyo Night"
    [materia-black]="Default Dark Modern"
  )

  local vscode_theme="${VSCODE_MAP[$theme]}"
  [[ -z "$vscode_theme" ]] && { echo "  vscode: no mapping for $theme, skipping"; return; }

  if command -v python3 &>/dev/null; then
    python3 - "$settings" "$vscode_theme" << 'PYEOF'
import json, sys
path, theme = sys.argv[1], sys.argv[2]
with open(path) as f:
    data = json.load(f)
data["workbench.colorTheme"] = theme
with open(path, "w") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
PYEOF
  else
    # Fallback: sed (fragile but works for simple cases)
    sed -i "s|\"workbench.colorTheme\":.*|\"workbench.colorTheme\": \"$vscode_theme\",|" "$settings"
  fi
  echo "  ✓ vscode"
}

# ── main ─────────────────────────────────────────────────────────────────────

THEME="${1:-}"

if [[ -z "$THEME" ]]; then
  THEME=$(pick_theme)
fi

[[ -z "$THEME" ]] && die "no theme selected"
theme_exists "$THEME" || die "unknown theme '$THEME'. Available: ${SUPPORTED_THEMES[*]}"

echo "Applying theme: $THEME"

apply_alacritty "$THEME"
apply_btop     "$THEME"
apply_neovim   "$THEME"
apply_zellij   "$THEME"
apply_vscode   "$THEME"

echo "$THEME" > "$CURRENT_FILE"
echo ""
echo "Theme '$THEME' applied."
[[ -f "$CURRENT_FILE" ]] && echo "Current theme saved to $CURRENT_FILE"
