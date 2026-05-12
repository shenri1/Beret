#!/usr/bin/env zsh
# dialog-helpers.sh — compatibility layer to replace gum with dialog
# Source this file to get gum-like functions backed by dialog

# Check dialog availability
if ! command -v dialog &>/dev/null; then
  echo "dialog not found. Install with: sudo dnf install dialog"
fi

# ── single-select menu ───────────────────────────────────────────────────────
# Usage: result=$(beret_dialog_menu "Title" "Option 1" "Description 1" ...)
# Returns: the selected tag (first word of the chosen option)
beret_dialog_menu() {
  local title="$1"
  shift
  local items=()
  while [[ $# -ge 2 ]]; do
    items+=("$1" "$2")
    shift 2
  done
  local tmpfile=$(mktemp)
  dialog --clear --menu "$title" 0 0 0 "${items[@]}" 2> "$tmpfile"
  local ret=$?
  cat "$tmpfile"
  rm -f "$tmpfile"
  return $ret
}

# ── multi-select checklist ───────────────────────────────────────────────────
# Usage: result=$(beret_dialog_checklist "Title" "Tag 1" "Desc 1" "Tag 2" ...)
# Returns: newline-separated list of selected tags
beret_dialog_checklist() {
  local title="$1"
  shift
  local items=()
  while [[ $# -ge 2 ]]; do
    items+=("$1" "$2" "off")
    shift 2
  done
  local tmpfile=$(mktemp)
  dialog --clear --checklist "$title" 0 0 0 "${items[@]}" 2> "$tmpfile"
  local ret=$?
  # dialog returns quoted space-separated tags like "tag1" "tag2"
  # convert to newline-separated
  sed 's/"//g' "$tmpfile" | tr ' ' '\n'
  rm -f "$tmpfile"
  return $ret
}

# ── text input ───────────────────────────────────────────────────────────────
# Usage: result=$(beret_dialog_input "Title" "Default text")
beret_dialog_input() {
  local title="$1"
  local default="${2:-}"
  local tmpfile=$(mktemp)
  dialog --clear --inputbox "$title" 0 0 "$default" 2> "$tmpfile"
  local ret=$?
  cat "$tmpfile"
  rm -f "$tmpfile"
  return $ret
}

# ── yes/no confirm ───────────────────────────────────────────────────────────
# Usage: beret_dialog_confirm "Question text"
beret_dialog_confirm() {
  dialog --clear --yesno "$1" 0 0
}

# ── info/progress box ────────────────────────────────────────────────────────
# Usage: beret_dialog_info "Message"
beret_dialog_info() {
  dialog --clear --infobox "$1" 3 50
}

# ── gum-compatible wrappers (accept same format as gum choose) ───────────────

# Multi-select from gum-style options
# Usage: result=$(beret_dialog_checklist_from_gum "Title" "Option 1" "Option 2" ...)
beret_dialog_checklist_from_gum() {
  local title="$1"
  shift
  local items=()
  local opt
  for opt in "$@"; do
    local tag=$(echo "$opt" | awk '{print $1}')
    local desc="${opt#${tag}}"
    desc=$(echo "$desc" | sed 's/^[[:space:]]*//')
    items+=("$tag" "$desc" "off")
  done
  local tmpfile=$(mktemp)
  dialog --clear --checklist "$title" 0 0 0 "${items[@]}" 2> "$tmpfile"
  local ret=$?
  sed 's/"//g' "$tmpfile" | tr ' ' '\n'
  rm -f "$tmpfile"
  return $ret
}

# Single-select from gum-style options
# Usage: result=$(beret_dialog_menu_from_gum "Title" "Option 1" "Option 2" ...)
beret_dialog_menu_from_gum() {
  local title="$1"
  shift
  local items=()
  local opt
  for opt in "$@"; do
    local tag=$(echo "$opt" | awk '{print $1}')
    local desc="${opt#${tag}}"
    desc=$(echo "$desc" | sed 's/^[[:space:]]*//')
    items+=("$tag" "$desc")
  done
  local tmpfile=$(mktemp)
  dialog --clear --menu "$title" 0 0 0 "${items[@]}" 2> "$tmpfile"
  local ret=$?
  cat "$tmpfile"
  rm -f "$tmpfile"
  return $ret
}
