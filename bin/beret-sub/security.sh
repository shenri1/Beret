#!/usr/bin/env bash

beret_die() {
  echo "ERROR: $*" >&2
  return 1
}

beret_valid_user() {
  local user="$1"
  [[ "$user" =~ ^[a-z_][a-z0-9_.-]*[$]?$ ]]
}

beret_resolve_user_home() {
  local user="$1"
  local home

  beret_valid_user "$user" || return 1
  home="$(getent passwd "$user" | cut -d: -f6)"

  [[ -n "$home" && "$home" != "/" && -d "$home" ]] || return 1
  printf '%s\n' "$home"
}

beret_setup_user_context() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    beret_die "This script must be run with sudo."
    return 1
  fi

  if [[ -z "${SUDO_USER:-}" || "$SUDO_USER" == "root" ]]; then
    beret_die "Run this from your normal user session with sudo, not from a root shell."
    return 1
  fi

  USER_HOME="$(beret_resolve_user_home "$SUDO_USER")" || {
    beret_die "Could not resolve a safe home directory for SUDO_USER='$SUDO_USER'."
    return 1
  }

  export SUDO_USER
  export USER_HOME
}

beret_make_temp_dir() {
  mktemp -d "${TMPDIR:-/tmp}/beret.XXXXXXXXXX"
}

beret_download() {
  local url="$1"
  local output="$2"

  curl --proto '=https' --tlsv1.2 --fail --show-error --location --output "$output" "$url"
}

# Ensures that the beret installation directory is owned by the target user
# and is not writable by group or others, preventing tampering in multi-user
# scenarios where sudo is used.
beret_validate_beret_dir_permissions() {
  local dir="${1:-$BASE_DIR}"
  local target_user="${2:-$SUDO_USER}"

  if [[ -z "$dir" || ! -d "$dir" ]]; then
    return 0
  fi

  # Check ownership
  local owner
  owner="$(stat -c '%U' "$dir" 2>/dev/null || stat -f '%Su' "$dir" 2>/dev/null)"
  if [[ -n "$target_user" && "$owner" != "$target_user" ]]; then
    beret_die "Directory '$dir' is owned by '$owner' but expected '$target_user'. Possible tampering."
    return 1
  fi

  # Check that it's not writable by group or others
  local perms
  perms="$(stat -c '%a' "$dir" 2>/dev/null || stat -f '%Lp' "$dir" 2>/dev/null)"
  # If perms is 3+ digits, check the last two digits (group and other)
  if [[ "${#perms}" -ge 2 ]]; then
    local group_perm other_perm
    group_perm="${perms: -2:1}"
    other_perm="${perms: -1:1}"
    if [[ "$group_perm" =~ [2367] || "$other_perm" =~ [2367] ]]; then
      beret_die "Directory '$dir' is group or world-writable (perms=$perms). Refusing to run for security."
      return 1
    fi
  fi

  return 0
}

beret_secure_beret_dir() {
  local dir="${1:-$BASE_DIR}"
  local target_user="${2:-$SUDO_USER}"

  if [[ -z "$dir" || ! -d "$dir" || -z "$target_user" ]]; then
    return 0
  fi

  chown -R "$target_user:$target_user" "$dir" 2>/dev/null || true
  chmod -R go-w "$dir" 2>/dev/null || true
}
