#!/usr/bin/env bash

# Agin, just to confirm, ask for default app choices
if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    OPTIONAL_APPS=("Proton-Pass" "Spotify" "Zoom" "Dropbox")
    DEFAULT_OPTIONAL_APPS='Proton-Pass,Spotify,Zoom'
    export BERRET_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected "$DEFAULT_OPTIONAL_APPS" --height 7 --header "Select optional apps" | tr ' ' '-')
fi

AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
SELECTED_LANGUAGES="Java","Python"
export OMAKUB_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="PostgreSQL"
export OMAKUB_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")
