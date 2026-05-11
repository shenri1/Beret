# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] — 2026-05-11

### Added

- **Modular CLI**: `beret` now supports subcommands — `install`, `uninstall`, `theme`, `font`, `font-size`, `update`, `help`
  - `beret install <component>` — installs one or more components by name
  - `beret uninstall <component>` — uninstalls one or more components by name
  - `beret theme <name>` — applies a theme to all supported apps at once
  - `beret font <name>` / `beret font-size <size>` — switches font and size via CLI
  - `beret update <component>` — updates a component (or `beret` for git pull)
  - Without arguments, opens an interactive multi-select picker via `gum`
  - `beret help` lists all available components and usage examples
- **Browser install scripts** (`install/desktop/browser/`): Firefox (`dnf`), Chromium (`dnf`), Brave (official repo), Zen Browser (`flatpak`)
- **Browser selection screen** (`browser/select.sh`) used during `desktop.sh` setup
- **Individual language uninstall scripts**: Rust, Go, Python, Java, Lua, Clang/C++, Swift
- **Individual browser uninstall scripts**: Firefox, Chromium, Zen Browser
- **IDE uninstall scripts**: Cursor, Antigravity
- **Kanagawa** theme added to the interactive theme picker
- `$SUDO_USER` validation in `install.sh` — refuses to run from a root shell (`sudo su`)
- `$USER_HOME` and `$SUDO_USER` exported from `install.sh` for all sourced scripts

### Fixed

- **IDE script naming mismatch**: `ide/select.sh` sourced `zed.sh`/`cursor.sh`/`vscode.sh` — corrected to match actual filenames (`app-*.sh`)
- **Missing browser install directory**: `desktop.sh` tried to source `browser/select.sh` which didn't exist — directory and scripts now created
- **Broken update paths**: `update.sh` pointed to non-existent IDE and browser files — all fixed
- **Discord Flatpak**: missing `-y` flag caused install to stall; `flatpak run` removed from installer
- **Invalid zsh syntax in `langs/select.sh`**: `clang/c++)` fixed to `clang)`
- **Typo in filename**: `set-alacritty-deafult.sh` → `set-alacritty-default.sh`

### Changed

- **Theme picker** (`bin/beret-sub/theme.sh`): replaced inline duplicate logic with delegate to `beret-theme`
- **Menu** (`bin/beret-sub/menu.sh`): now delegates all operations to `beret` CLI subcommands
- **Uninstall picker** (`bin/beret-sub/uninstall.sh`): replaced file-browser approach with component picker
- **_app-discord.sh_**: simplified to a single `flatpak install -y` line
