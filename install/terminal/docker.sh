#!/usr/bin/env zsh

# Add the official Docker repo
dnf config-manager addrepo --overwrite --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker engine and standard plugins
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Give this user privileged Docker access
usermod -aG docker $SUDO_USER

# Limit log size to avoid running out of disk
mkdir -p /etc/docker
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | tee /etc/docker/daemon.json

systemctl enable --now docker
