#!/usr/bin/env zsh

SERVICES_OPTIONS=(
    "Docker        Container runtime + compose plugin"
    "PostgreSQL    Relational database + libpq-devel"
    "Redis         In-memory key-value store"
    "MySQL         MySQL server + client dev libraries"
    "SQLite        Embedded database + dev library"
)

SELECTED=$(gum choose "${SERVICES_OPTIONS[@]}" \
    --no-limit \
    --height 10 \
    --header "Select development services to install (Space to select, Enter to skip):")

[[ -z "$SELECTED" ]] && return

echo "$SELECTED" | while IFS= read -r line; do
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
