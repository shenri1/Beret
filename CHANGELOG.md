# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.2] - 2026-05-14

### Security

- Replaced `curl | sh` / `curl | zsh` installer flows for Rust, Zed, and OpenCode with TLS-only downloads to private temporary directories before execution.
- Removed `eval echo ~$SUDO_USER` from the `beret` CLI and now resolves the invoking user's home directory through `getent`.
- Added shared sudo-user validation for the main installer, rejecting root-shell execution and unsafe `SUDO_USER` values before privileged file operations.
- Replaced the fixed `/tmp/beret-install.log` path with a random `mktemp` log file to avoid symlink/clobbering risks.
- Switched downloaded archives and AppImages away from predictable filenames in `/tmp`, using per-run temporary directories for fonts, Go, Swift, Neovim, Zellij, Lazygit, Lazydocker, and Cursor.

### Changed

- Scripts now prefer the validated `USER_HOME` or resolve the user's home directory with `getent` instead of assuming `/home/$SUDO_USER`.
- Removed unnecessary `cd /tmp` usage from the dialog installer.

## [0.1.1] — 2026-05-11

### Added

- **Aether integration**: custom theme creator via GUI (`beret aether`)
  - Install with `beret install aether` (pulls Aether GTK app + dependencies)
  - `beret-aether-bridge` converts Aether color palette into Beret-compatible theme files for Alacritty, Zellij, btop, Neovim, and VS Code
  - `beret aether` launches the GUI, then auto-applies the generated custom theme
  - `beret theme custom` reapplies the last generated custom theme
- **Modular CLI**: `beret` now supports subcommands — `install`, `uninstall`, `theme`, `font`, `font-size`, `update`, `help`, `aether`
  - `beret install <component>` — installs one or more components by name
  - `beret uninstall <component>` — uninstalls one or more components by name
  - `beret theme <name>` — applies a theme to all supported apps at once
  - `beret font <name>` / `beret font-size <size>` — switches font and size via CLI
  - `beret update <component>` — updates a component (or `beret` for git pull)
  - Without arguments, opens an interactive picker via `dialog` (ncurses TUI)
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

- **Swift installer root $HOME**: double-quoted `sudo -u ... zsh -c` caused `$HOME` to resolve as root — switched to single quotes with exported `$ARCH`
- **Neovim transparency path**: configs copied to `plugin/after/` (not a valid Neovim runtime directory) — corrected to `after/plugin/`
- **Neovim duplicate `relativenumber`**: appended on every reinstall — now guarded with `grep -q`
- **Antigravity missing `-y`**: `dnf install antigravity` without `-y` would stall — added `-y`
- **Java uninstall version mismatch**: `all.sh` used `java-latest-openjdk` but install uses `java-21-openjdk` — aligned to `java-21-openjdk`
- **Zed uninstall path**: only removed `~/.local/bin/zed` but installer may put binary in `/usr/local/bin/` — added both paths
- **Clang/C++ language selector**: case pattern in `langs/select.sh` didn't match `clang/c++` from the display name — fixed to `clang*)` wildcard
- **Discord uninstall mismatch**: installer used Flatpak but uninstaller used `dnf` — corrected to `flatpak uninstall`
- **Ollama in update.sh**: referenced non-existent `optional/app-ollama.sh` — removed from update menu
- **VS Code theme duplication**: `beret-theme` had a hardcoded `VSCODE_MAP` parallel to per-theme `vscode.sh` files — now delegates to `vscode.sh` for all themes
- **`bc` dependency in check-version.sh**: replaced with native zsh arithmetic `(( VERSION_ID < 41 ))`
- **`$SUDO_USER` / `$HOME` resolution in beret CLI**: `beret install/uninstall/update` now auto-elevates via sudo and resolves the user's home via `~$SUDO_USER`
- **Stale reference in CONTRIBUTING.md**: `set-git.sh` → `setting.sh` for config copying

### Changed

- **`chown` scope in setting.sh**: was `chown -R` on entire `~/.config` — now targets only Beret-managed subdirectories (alacritty, btop, fastfetch, zellij, nvim, xournalpp)
- **font-size**: now also updates VS Code's `editor.fontSize` and `terminal.integrated.fontSize`
- **font selector**: now also updates VS Code's `terminal.integrated.fontFamily` and checks settings.json existence
- **`set-alacritty-default.sh`**: replaced Debian-specific `update-alternatives` with `gsettings` and `xdg-mime` for Fedora/KDE
- **Alacritty shell config**: removed duplicate `[terminal.shell]` block from `config/alacritty.toml` (was overridden by `shared.toml`)
- **Desktop fonts**: iA Writer download now checks `fc-list` before downloading (avoid redundant download when `install/fonts.sh` ran first)
- **Ulauncher**: replaced `gtk-launch` with direct Flatpak binary path
- **`app-lazydocker.sh`**: removed redundant `sudo` (script already runs as root)
- **`setting.sh`**: removed unnecessary `chmod +x` on sourced zsh modules
- **`beret` CLI**: added `local` to previously unqualified `install_dir` and `uninstall_dir`; suppressed `cd -` output
- **Quoting**: fixed unquoted variable expansions in `install/fonts.sh` and `install/desktop/fonts.sh`
