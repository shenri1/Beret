# Beret — Fedora KDE Setup

Personal dotfiles and automated setup for a Fedora KDE environment. Installs packages, configures the desktop, sets up the terminal, and applies all config files in one shot.

After the initial setup, the `beret` CLI lets you install, uninstall, and update individual components — languages, IDEs, browsers, terminal tools, and desktop apps — without re-running the full installer.

---

## Requirements

- Fresh **Fedora KDE** installation (41+)
- Internet connection
- A non-root user account with `sudo` privileges

---

## Quick Start

### 1. Clone the repository

```zsh
git clone https://github.com/shenri1/beret.git ~/.local/share/beret
cd ~/.local/share/beret
```

### 2. Run the installer

The installer must be run with `sudo`, but **not as root directly**. It needs to know your actual user account to configure files correctly.

```zsh
sudo ./install.sh
```

> ⚠️ Do not run `sudo su` first and then `./install.sh`. Use `sudo ./install.sh` from your normal user session.

### 3. Follow the prompts

During installation, you will be asked for your **name** and **email address**. These are used to configure Git and generate XCompose shortcuts for quickly typing your identification.

### 4. Reboot

Once the script finishes, reboot your system for all changes to take effect.

```zsh
reboot
```

---

## Post-install: the `beret` CLI

After setup, the `beret` command is available from your terminal. Use it to manage individual components without re-running the full installer.

```zsh
beret                    # Interactive menu
beret help               # Show all commands and components
```

### Managing components

```zsh
# Install individual components
beret install zed rust go

# Uninstall individual components
beret uninstall firefox

# Interactive picker — select multiple with space, confirm with enter
beret install
beret uninstall
```

### Themes

```zsh
# Interactive picker
beret theme

# Apply a specific theme to all apps (Alacritty, Neovim, Zellij, btop, VS Code)
beret theme tokyo-night
beret theme catppuccin

# Create a custom theme via Aether GUI
beret aether
```

8 curated themes plus a custom theme generator:

| Theme            | Alacritty | btop | Neovim            | Zellij | VS Code               |
|------------------|-----------|------|-------------------|--------|-----------------------|
| Tokyo Night      | ✓         | ✓    | tokyonight-storm  | ✓      | Tokyo Night Storm     |
| Catppuccin       | ✓         | ✓    | catppuccin        | ✓      | Catppuccin Mocha      |
| Gruvbox          | ✓         | ✓    | gruvbox           | ✓      | Gruvbox Dark Medium   |
| Kanagawa         | ✓         | ✓    | kanagawa          | ✓      | Kanagawa              |
| Nordic           | ✓         | ✓    | nordic            | ✓      | Nord                  |
| Osaka Jade       | ✓         | ✓    | osaka-jade        | ✓      | Ocean Green: Dark     |
| Rosé Pine        | ✓         | ✓    | rosé-pine         | ✓      | Rosé Pine             |
| Materia Black    | ✓         | ✓    | materia-black     | ✓      | Matte Black Theme     |
| Custom (Aether)  | ✓         | ✓    | custom highlights | ✓      | custom color palette  |

Use `beret aether` to create your own color scheme via the Aether GUI.

---

## Available components

| Category       | Components                                                                                       |
|----------------|--------------------------------------------------------------------------------------------------|
| **Languages**  | `rust`, `go`, `python`, `java`, `lua`, `clang`, `swift`                                         |
| **IDEs**       | `zed`, `cursor`, `vscode`, `antigravity`                                                        |
| **Browsers**   | `firefox`, `chromium`, `brave`, `zen`                                                           |
| **Terminal**   | `neovim`, `zellij`, `lazygit`, `lazydocker`, `btop`, `fastfetch`, `gh`, `docker`                |
| **Desktop apps** | `discord`, `spotify`, `obs`, `krita`, `virtualbox`, `xournalpp`, `alacritty`, `ulauncher`       |
| **Themes**     | `aether` (custom theme creator via GUI)                                                          |

---

## Structure

```
beret/
├── install.sh              # Main entry point
├── ascii.sh                # ANSI-colored ASCII art banner
├── install/                # Setup scripts, run in order by install.sh
│   ├── terminal/           # Shell, libraries, languages, terminal apps
│   └── desktop/            # Flatpak, fonts, Alacritty, browsers, IDEs, apps
├── config/                 # App config files, copied to ~/.config
├── default/                # Zsh modules and XCompose, copied to ~/.local/share/beret
├── bin/                    # Utility scripts (beret, beret-theme, beret-aether-bridge, fedora-maintenance)
│   └── beret-sub/          # Sub-modules for the beret interactive menu
├── themes/                 # Cross-app theme ecosystem (8 curated themes + custom Aether generator)
├── uninstall/              # Per-component uninstall scripts
└── CHANGELOG.md
```

---

## License

MIT License

Copyright (c) 2026 Silas Cerqueira
