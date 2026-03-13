#!/usr/bin/env zsh

rpm --import https://packages.microsoft.com/keys/microsoft.asc

tee /etc/yum.repos.d/vscode.repo > /dev/null << 'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf install -y code

# Install default theme extension (tokyo-night)
sudo -u "$SUDO_USER" code --install-extension enkia.tokyo-night --force 2>/dev/null || true

# Apply default settings
USER_HOME="/home/$SUDO_USER"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/Code/User"

SETTINGS_FILE="$USER_HOME/.config/Code/User/settings.json"
if [[ ! -f "$SETTINGS_FILE" ]]; then
  sudo -u "$SUDO_USER" tee "$SETTINGS_FILE" > /dev/null << 'EOF'
{
  "workbench.colorTheme": "Tokyo Night Storm",
  "editor.fontFamily": "'JetBrainsMono Nerd Font', monospace",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "editor.lineHeight": 1.6,
  "editor.tabSize": 2,
  "editor.rulers": [120],
  "editor.formatOnSave": true,
  "editor.minimap.enabled": false,
  "editor.renderWhitespace": "boundary",
  "editor.smoothScrolling": true,
  "editor.cursorBlinking": "solid",
  "editor.cursorSmoothCaretAnimation": "on",
  "workbench.startupEditor": "none",
  "workbench.editor.enablePreview": false,
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font'",
  "terminal.integrated.fontSize": 14,
  "window.titleBarStyle": "custom"
}
EOF
  chown "$SUDO_USER:$SUDO_USER" "$SETTINGS_FILE"
fi
