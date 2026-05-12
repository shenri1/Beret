#!/usr/bin/env zsh

echo "Installing Antigravity..."

tee /etc/yum.repos.d/antigravity.repo << 'EOL'
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL

dnf makecache

dnf install -y antigravity

cd -
echo "✓ Antigravity installed."
