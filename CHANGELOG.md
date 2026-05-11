# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] — 2026-05-11

### Added

- **Modular CLI**: `beret` now supports subcommands — `install`, `uninstall`, `theme`, `font`, `font-size`, `update`
  - `beret install <component>` — installs one or more components by name
  - `beret uninstall <component>` — uninstalls one or more components by name
  - `beret theme <name>` — applies a theme to all supported apps at once
  - `beret font <name>` / `beret font-size <size>` — switches font and size via CLI
  - `beret update <component>` — updates a component (or `beret` for git pull)
  - Without arguments, opens an interactive multi-select picker via `gum`
- **Browser install scripts**: Firefox (`dnf`), Chromium (`dnf`), Brave (official repo), Zen Browser (`flatpak`)
- **Browser selection screen** (`install/desktop/browser/select.sh`) used during `desktop.sh` setup
- **Individual language uninstall scripts**: Rust, Go, Python, Java, Lua, Clang/C++, Swift
- **Individual browser uninstall scripts**: Firefox, Chromium, Zen Browser
- **IDE uninstall scripts**: Cursor, Antigravity
- **Kanagawa** theme added to the interactive theme picker
- `$SUDO_USER` validation in `install.sh` — refuses to run from a root shell (`sudo su`)
- `$USER_HOME` and `$SUDO_USER` exported from `install.sh` for all sourced scripts
- `beret help` subcommand listing all available components

### Fixed

- **IDE script naming mismatch**: `ide/select.sh` sourced `zed.sh`/`cursor.sh`/`vscode.sh`/`antigravity.sh` — corrected to `app-zed.sh`/`app-cursor.sh`/`app-code.sh`/`app-antigravity.sh` (the actual filenames)
- **Missing browser install directory**: `desktop.sh` tried to source `install/desktop/browser/select.sh` which didn't exist — directory and scripts now created
- **Broken paths in `update.sh`**: IDE and browser update cases pointed to non-existent files (`ide/zed.sh`, `ide/cursor.sh`, `ide/vscode.sh`, `browser/zen.sh`, `browser/brave.sh`) — all fixed
- **Discord Flatpak hang**: `app-discord.sh` was missing the `-y` flag, causing install to stall; also removed `flatpak run` that launched the app during setup
- **Invalid zsh case syntax in `langs/select.sh`**: `clang/c++)` had a stray `/` — fixed to `clang)`
- **Typo in filename**: `set-alacritty-deafult.sh` → `set-alacritty-default.sh`
- **Duplicate theme logic**: `beret-sub/theme.sh` had its own inline code duplicating `beret-theme` — now delegates to it directly

### Changed

- **Component picker**: the old `menu.sh` now delegates all operations to the new `beret` CLI subcommands
- **`install/desktop/app-discord.sh`**: simplified to a single `flatpak install -y` line
- **`bin/beret-sub/theme.sh`**: reduced from inline theme applier to a one-line delegate to `beret-theme`
- **`bin/beret-sub/uninstall.sh`**: replaced file-browser approach with the new component picker
