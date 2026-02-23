# Berret — Fedora KDE Setup

Personal dotfiles and automated setup for a Fedora KDE environment. Installs packages, configures the desktop, sets up the terminal, and applies all config files in one shot.

---

## Requirements

- Fresh **Fedora KDE** installation
- Internet connection
- A non-root user account with `sudo` privileges

---

## Usage

### 1. Clone the repository

```bash
git clone https://github.com/your-username/berret.git ~/.local/share/berret
cd ~/.local/share/berret
```

### 2. Run the installer

The installer must be run with `sudo`, but **not as root directly**. It needs to know your actual user account to configure files correctly.

```bash
sudo ./install.sh
```

> ⚠️ Do not run `sudo su` first and then `./install.sh`. Use `sudo ./install.sh` from your normal user session.

### 3. Follow the prompts

During installation, you will be asked for your **name** and **email address**. These are used to configure Git and generate XCompose shortcuts for quickly typing your identification.

### 4. Reboot

Once the script finishes, reboot your system for all changes to take effect.

```bash
reboot
```

---

## What gets configured

After installation, the following will be set up under your home directory:

- **`~/.bashrc`** — sources the Berret shell config (aliases, functions, prompt, editor)
- **`~/.config/`** — receives app configs (kitty, btop, fastfetch, xournalpp)
- **`~/.local/share/berret/`** — stores the bash modules and XCompose file
- **`~/.XCompose`** — keyboard shortcuts for emoji and typography, plus your name/email

---

## Post-install maintenance

A utility script is available to keep the system clean:

```bash
fedora-maintenance
```

This removes orphaned RPM packages, cleans DNF cache, removes unused Flatpaks, and clears the KDE thumbnail cache.

---

## Structure

```
berret/
├── install/          # Numbered setup scripts, run in order by install.sh
├── config/           # App config files, copied to ~/.config
├── default/          # Bash modules and XCompose, copied to ~/.local/share/berret
├── bin/              # Utility scripts, installed to /usr/local/bin
└── install.sh        # Main entry point
```

---

## License

MIT License

Copyright (c) 2026 Silas Cerqueira

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
