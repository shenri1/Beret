#!/usr/bin/env zsh

echo "Installing Brave Browser..."

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

tee /etc/yum.repos.d/brave-browser.repo > /dev/null << 'EOF'
[brave-browser]
name=Brave Browser
baseurl=https://brave-browser-rpm-release.s3.brave.com/x86_64/
enabled=1
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
EOF

dnf install -y brave-browser
echo "✓ Brave installed."
