# Beret — Fedora KDE Setup

Personal dotfiles and automated setup for a Fedora KDE environment. Installs packages, configures the desktop, sets up the terminal, and applies all config files in one shot.

---

## Requirements

- Fresh **Fedora KDE** installation
- Internet connection
- A non-root user account with `sudo` privileges

---

## Usage

### 1. Clone the repository

<<<<<<< HEAD
```bash
git clone https://github.com/shenri1/beret.git ~/.local/share/beret
cd ~/.local/share/beret
=======
```zsh
git clone https://github.com/shenri1/berret.git ~/.local/share/berret
cd ~/.local/share/berret
>>>>>>> 2c65214 (Changes bash to zsh in scripts)
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

## What gets configured

After installation, the following will be set up under your home directory:

<<<<<<< HEAD
- **`~/.bashrc`** — sources the Beret shell config (aliases, functions, prompt, editor)
- **`~/.config/`** — receives app configs (kitty, btop, fastfetch, xournalpp)
- **`~/.local/share/beret/`** — stores the bash modules and XCompose file
=======
- **`~/.zshrc`** — sources the Berret shell config (aliases, functions, prompt, editor)
- **`~/.config/`** — receives app configs (kitty, btop, fastfetch, xournalpp)
- **`~/.local/share/berret/`** — stores the zsh modules and XCompose file
>>>>>>> 2c65214 (Changes bash to zsh in scripts)
- **`~/.XCompose`** — keyboard shortcuts for emoji and typography, plus your name/email

---

## Post-install maintenance

A utility script is available to keep the system clean:

```zsh
fedora-maintenance
```

This removes orphaned RPM packages, cleans DNF cache, removes unused Flatpaks, and clears the KDE thumbnail cache.

---

## Structure

```
beret/
├── install/          # Numbered setup scripts, run in order by install.sh
├── config/           # App config files, copied to ~/.config
<<<<<<< HEAD
├── default/          # Bash modules and XCompose, copied to ~/.local/share/beret
=======
├── default/          # Zsh modules and XCompose, copied to ~/.local/share/berret
>>>>>>> 2c65214 (Changes bash to zsh in scripts)
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
