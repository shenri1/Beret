# Contributing

This is a personal setup repo, but contributions are welcome — whether it's a bug fix, a new config, or an improvement to the install scripts.

---

## Getting started

1. Fork the repository and clone your fork
2. Create a branch for your change: `git checkout -b my-change`
3. Make your changes (see guidelines below)
4. Test by running `sudo ./install.sh` on a fresh Fedora KDE install, or at minimum running the affected script manually
5. Open a pull request with a clear description of what changed and why

---

## Adding a new install script

Install scripts live in `install/` and are sourced in alphabetical order. A few rules to follow:

- **Use `#!/usr/bin/env zsh`** at the top of every script
- **End with `clear`** to keep the terminal output clean between steps
- **Use `$SUDO_USER` and `$USER_HOME`** when writing files to the user's home directory — the script runs as root, so `$HOME` will resolve to `/root`
- **Use `sudo -u "$SUDO_USER" zsh -c '...'`** when commands must run as the regular user (e.g. installing user-level tools, writing dotfiles)
- **Always pass `-y`** to `dnf install` so the script doesn't stall waiting for input
- **Never use `sudo` inside these scripts** — they already run as root via `sudo ./install.sh`
- **Use `$BASE_DIR`** for all paths into the repo — never hardcode `~/.local/share/beret/`

---

## Adding or updating a config file

Config files live in `config/` and are copied to `~/.config/` during `set-git.sh`.

- Add your file at the matching path under `config/`, e.g. `config/myapp/settings.conf`
- Avoid hardcoding usernames or home paths — the install script handles that
- If your config needs dynamic content (like the user's name or email), handle it inside the install script rather than in the config file itself

---

## Shell modules

The default shell for beret is **zsh** (via Oh My Zsh). Shell config lives in `default/zsh/` and is split into focused files:

| File | Purpose |
|------|---------|
| `aliases` | Short command aliases |
| `functions` | Shell functions |
| `prompt` | ZSH prompt (vcs_info, user@host visible in terminal) |
| `editor` | Default editor env vars |
| `shell` | History, PATH, shell options |
| `init` | Tool initialization (zoxide, fzf, ZLE keybinds) |
| `inputrc` | Readline config |
| `rc` | Entry point — sources all of the above |

Zsh fallback modules live in `default/zsh/` using the same structure with zsh-compatible syntax.

Keep each file focused on its purpose. If something doesn't fit cleanly, create a new file and source it from `rc`.

---

## Code style

- Use `#!/usr/bin/env zsh` at the top of every script
- Prefer `[[ ]]` over `[ ]` for conditionals in zsh
- Quote all variables: `"$VAR"`, not `$VAR`
- Keep scripts idempotent where possible — safe to run more than once without breaking things
- Use `$BASE_DIR` for all paths into the beret repo
