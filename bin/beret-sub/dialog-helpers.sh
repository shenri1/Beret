#!/usr/bin/env zsh
# dialog-helpers.sh — compatibility layer backed by gum
# Source this file to get interactive dialog functions powered by gum

# Check gum availability
if ! command -v gum &>/dev/null; then
  echo "gum not found. Install with: sudo dnf install gum"
fi

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
  selected=$(gum choose --header="$title" "${lines[@]}")
  [[ -z "$selected" ]] && return 1
  echo "$selected" | sed 's/ —.*//'
}

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
  selected=$(gum choose --header="$title" --no-limit "${lines[@]}")
  [[ -z "$selected" ]] && return 1
  echo "$selected" | sed 's/ —.*//'
}

beret_dialog_input() {
  local title="$1"
  local default="${2:-}"
  if [[ -n "$default" ]]; then
    gum input --prompt="$title: " --value="$default"
  else
    gum input --prompt="$title: "
  fi
}

beret_dialog_confirm() {
  gum confirm "$1"
}

beret_dialog_info() {
  gum style --bold "$1"
}

beret_dialog_checklist_from_gum() {
  local title="$1"
  shift
  local options=()
  for opt in "$@"; do
    [[ -n "$opt" ]] && options+=("$opt")
  done
  local selected
  selected=$(gum choose --header="$title" --no-limit "${options[@]}")
  [[ -z "$selected" ]] && return 1
  echo "$selected"
}

beret_dialog_menu_from_gum() {
  local title="$1"
  shift
  local options=()
  for opt in "$@"; do
    [[ -n "$opt" ]] && options+=("$opt")
  done
  local selected
  selected=$(gum choose --header="$title" "${options[@]}")
  [[ -z "$selected" ]] && return 1
  echo "$selected"
}
