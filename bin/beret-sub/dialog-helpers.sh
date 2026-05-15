#!/usr/bin/env zsh
# dialog-helpers.sh — compatibility layer to replace dialog with fzf
# Source this file to get gum-like functions backed by fzf

# Check fzf availability
if ! command -v fzf &>/dev/null; then
  echo "fzf not found. Install with: sudo dnf install fzf"
fi

# ── single-select menu ───────────────────────────────────────────────────────
# Usage: result=$(beret_dialog_menu "Title" "Option 1" "Description 1" ...)
# Returns: the selected tag (first word of the chosen option)
beret_dialog_menu() {
  local title="$1"
  shift
  local lines=()
  while [[ $# -ge 2 ]]; do
    local tag="$1"
    local desc="$2"
    if [[ -n "$desc" ]]; then
      lines+=("${tag} — ${desc}")
    else
      lines+=("${tag}")
    fi
    shift 2
  done
  local selected
  selected=$(printf '%s\n' "${lines[@]}" | fzf --prompt="${title}: " --height=~50% --layout=reverse --border)
  [[ -z "$selected" ]] && return 1
  echo "$selected" | sed 's/ —.*//'
}

# ── multi-select checklist ───────────────────────────────────────────────────
# Usage: result=$(beret_dialog_checklist "Title" "Tag 1" "Desc 1" "Tag 2" ...)
# Returns: newline-separated list of selected tags
beret_dialog_checklist() {
  local title="$1"
  shift
  local lines=()
  while [[ $# -ge 2 ]]; do
    local tag="$1"
    local desc="$2"
    if [[ -n "$desc" ]]; then
      lines+=("${tag} — ${desc}")
    else
      lines+=("${tag}")
    fi
    shift 2
  done
  local selected
  selected=$(printf '%s\n' "${lines[@]}" | fzf -m --prompt="${title}: " --height=~50% --layout=reverse --border)
  [[ -z "$selected" ]] && return 1
  echo "$selected" | sed 's/ —.*//'
}

# ── text input ───────────────────────────────────────────────────────────────
# Usage: result=$(beret_dialog_input "Title" "Default text")
beret_dialog_input() {
  local title="$1"
  local default="${2:-}"
  local result
  if [[ -n "$default" ]]; then
    read -rp "${title} [${default}]: " result
    [[ -z "$result" ]] && result="$default"
  else
    read -rp "${title}: " result
  fi
  echo "$result"
}

# ── yes/no confirm ───────────────────────────────────────────────────────────
# Usage: beret_dialog_confirm "Question text"
beret_dialog_confirm() {
  local result
  result=$(printf "Yes\nNo\n" | fzf --prompt="$1 " --height=~20% --layout=reverse --border)
  [[ "$result" == "Yes" ]]
}

# ── info/progress box ────────────────────────────────────────────────────────
# Usage: beret_dialog_info "Message"
beret_dialog_info() {
  echo "$1"
}

# ── gum-compatible wrappers (accept same format as gum choose) ───────────────

# Multi-select from gum-style options
# Usage: result=$(beret_dialog_checklist_from_gum "Title" "Option 1" "Option 2" ...)
beret_dialog_checklist_from_gum() {
  local title="$1"
  shift
  local selected
  selected=$(printf '%s\n' "$@" | fzf -m --prompt="${title}: " --height=~50% --layout=reverse --border)
  [[ -z "$selected" ]] && return 1
  echo "$selected"
}

# Single-select from gum-style options
# Usage: result=$(beret_dialog_menu_from_gum "Title" "Option 1" "Option 2" ...)
beret_dialog_menu_from_gum() {
  local title="$1"
  shift
  local selected
  selected=$(printf '%s\n' "$@" | fzf --prompt="${title}: " --height=~50% --layout=reverse --border)
  [[ -z "$selected" ]] && return 1
  echo "$selected"
}
