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

```bash
git clone https://github.com/shenri1/beret.git ~/.local/share/beret
cd ~/.local/share/beret
```

### 2. Run the installer

The installer must be run with sudo, but not as root directly. It needs to know your actual user account to configure files correctly.

```bash
sudo ./install.sh
```

⚠️ Do not run sudo su first and then ./install.sh. Use sudo ./install.sh from your normal user session.

### 3. Follow the prompts

During installation, you will be asked for your name and email address. These are used to configure Git and generate XCompose shortcuts for quickly typing your identification.

### 4. Reboot

Once the script finishes, reboot your system for all changes to take effect.

```bash
reboot
```

Post-install: the beret CLI
After setup, the beret command is available from your terminal. Use it to manage individual components without re-running the full installer.

```bash
beret                    # Interactive menu
beret help               # Show all commands and components
```

#### Managing components

```bash
# Install individual components
beret install zed rust go

# Uninstall individual components
beret uninstall firefox

# Interactive picker — select multiple with space, confirm with enter
beret install
beret uninstall
```

#### Themes
```bash
# Interactive picker
beret theme

# Apply a specific theme to all apps (Alacritty, Neovim, Zellij, btop, VS Code)
beret theme tokyo-night
beret theme catppuccin
```

#### Fonts

```bash
# Interactive picker
beret font

# Set a specific font
beret font "JetBrains Mono"

# Adjust font size
beret font-size 12
```

#### Updating

```bash
# Interactive picker
beret update

# Update the beret tool itself
beret update beret

# Update a specific app (re-runs its installer)
beret update neovim
```
#### Available components

| Category  | Components  |
|---|---|
| Languages | rust, go, python, java, lua, clang, swift |
| IDEs | zed, cursor, vscode, antigravity |
| Browsers | firefox, chromium, brave, zen |
| Terminal | neovim, zellij, lazygit, lazydocker, btop, fastfetch, gh, docker |
| Desktop apps | discord, spotify, obs, krita, virtualbox, xournalpp, alacritty, ulauncher |


#### Maintenance 
```bash
fedora-maintenance
```

Removes orphaned RPM packages, cleans DNF cache, removes unused Flatpaks, and clears the KDE thumbnail cache.

#### What gets configured
After installation, the following will be set up under your home directory:

- ~/.zshrc — sources the Beret shell config (aliases, functions, prompt, editor, completions)
- ~/.config/ — receives app configs (Alacritty, Zellij, btop, fastfetch, Neovim, Xournal++)
- ~/.local/share/beret/ — stores the zsh modules, themes, and XCompose file
- ~/.XCompose — keyboard shortcuts for emoji and typography, plus your name/email

#### Installed tools

- Shell: zsh + Oh My Zsh with syntax highlighting and autosuggestions plugins
- Terminal: Alacritty (default) with Zellij multiplexer
- Editor: Neovim (LazyVim starter with Tokyo Night theme)
- Monitoring: fastfetch (system info), btop (resources)
- Git tools: lazygit, lazydocker, GitHub CLI
- Dev libraries: openssl, sqlite, libyaml, redis, postgresql, and more
- Programming languages (optional, selected during install): Rust, Go, Python, Java, Lua, Clang/C++, Swift
- Desktop apps (optional): Discord, Spotify, OBS, Krita, VirtualBox, Xournal++
- Browsers (optional): Firefox, Chromium, Brave, Zen Browser
- IDEs (optional): Zed, Cursor, VS Code, Antigravity

#### Themes

8 themes supported across 5 applications (Alacritty, btop, Neovim, Zellij, VS Code):

|Theme|	Alacritty|	btop|	Neovim|	Zellij|	VS Code|
|:---|:---|:---|:---|:---|:---|
|Tokyo Night (default)|	✓|	✓	|tokyonight-storm|	✓|	Tokyo Night Storm|
|Catppuccin|	✓|	✓	|catppuccin|	✓|	Catppuccin Mocha|
|Gruvbox|	✓|	✓	|gruvbox|	✓|	Gruvbox Dark Medium|
|Kanagawa|	✓|	✓	|kanagawa|	✓|	Kanagawa|
|Nordic|	✓|	✓	|nordic|	✓|	Nord|
|Osaka Jade|	✓|	✓	|osaka-jade|	✓|	Ocean Green: Dark|
|Rosé Pine|	✓|	✓	|rosé-pine|	✓|	Rosé Pine|
|Materia Black|	✓|	✓	|materia-black|	✓|	Matte Black Theme|

#### Structure

```bash
beret/
├── install.sh              # Main entry point
├── ascii.sh                # ANSI-colored ASCII art banner
├── install/                # Numbered setup scripts, run in order by install.sh
│   ├── terminal/           # Shell, libraries, languages, terminal apps
│   └── desktop/            # Flatpak, fonts, Alacritty, browsers, IDEs, apps
├── config/                 # App config files, copied to ~/.config
├── default/                # Zsh modules and XCompose, copied to ~/.local/share/beret
├── bin/                    # Utility scripts (beret, beret-theme, fedora-maintenance)
│   └── beret-sub/          # Sub-modules for the beret interactive menu
├── themes/                 # Cross-app theme ecosystem (8 themes)
├── uninstall/              # Per-component uninstall scripts
└── version
```

License

MIT License

Copyright (c) 2026 Silas Cerqueira
