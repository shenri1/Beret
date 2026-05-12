#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

SERVICES_OPTIONS=(
    "Docker        Container runtime + compose plugin"
    "PostgreSQL    Relational database + libpq-devel"
    "Redis         In-memory key-value store"
    "MySQL         MySQL server + client dev libraries"
    "SQLite        Embedded database + dev library"
)

SELECTED=$(beret_dialog_checklist_from_gum "Select development services to install (Enter to skip):" "${SERVICES_OPTIONS[@]}")

[[ -z "$SELECTED" ]] && return

echo "$SELECTED" | while IFS= read -r line; do
    local line svc
    svc=$(echo "$line" | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
    case "$svc" in
        docker)
            source "$BASE_DIR/install/terminal/docker.sh"
            ;;
        postgresql)
            dnf install -y postgresql postgresql-server libpq-devel
            ;;
        redis)
            dnf install -y redis
            ;;
        mysql)
            dnf install -y mysql-devel
            ;;
        sqlite)
            dnf install -y sqlite sqlite-devel
            ;;
    esac
done
