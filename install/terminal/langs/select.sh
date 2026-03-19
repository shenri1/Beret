#!/usr/bin/env zsh

# Language options shown to user
LANG_OPTIONS=(
    "Rust        Systems language (rustup)"
    "Go          Google's compiled language"
    "Python      Scripting and data science"
    "Java        OpenJDK 21"
    "Lua         Lightweight scripting (used by Neovim)"
    "Clang/C++   C, C++, LLVM toolchain"
    "Swift       Apple's open-source language"
)

clear
source "$BASE_DIR/ascii.sh"
echo ""

SELECTED=$(gum choose "${LANG_OPTIONS[@]}" \
    --no-limit \
    --height 12 \
    --header "Select programming languages to install (Space to select, Enter to confirm):")

[[ -z "$SELECTED" ]] && return

echo "$SELECTED" | while IFS= read -r line; do
    lang=$(echo "$line" | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
    case "$lang" in
        rust)   source "$BASE_DIR/install/terminal/langs/rust.sh" ;;
        go)     source "$BASE_DIR/install/terminal/langs/golang.sh" ;;
        python) source "$BASE_DIR/install/terminal/langs/python.sh" ;;
        java)   source "$BASE_DIR/install/terminal/langs/java.sh" ;;
        lua)    source "$BASE_DIR/install/terminal/langs/lua.sh" ;;
        clang/c++) source "$BASE_DIR/install/terminal/langs/clang.sh" ;;
        swift)  source "$BASE_DIR/install/terminal/langs/swift.sh" ;;
    esac
done

clear
