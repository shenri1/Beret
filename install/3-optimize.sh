#!/usr/bin/env bash

echo "Optimizing systemd services..."
# Prevents boot delays while waiting for the network
systemctl disable NetworkManager-wait-online.service || true

echo "Disabling file indexer (Baloo) for all users..."
# Baloo frequently causes 100% CPU/Disk usage spikes
for user_dir in /home/*; do
    if [ -d "$user_dir" ]; then
        user=$(basename "$user_dir")
        sudo -u "$user" balooctl6 disable 2>/dev/null || sudo -u "$user" balooctl disable 2>/dev/null || true
        sudo -u "$user" balooctl6 purge 2>/dev/null || sudo -u "$user" balooctl purge 2>/dev/null || true
    fi
done

echo "Applying Kernel optimizations (Sysctl)..."
cat <<EOF > /etc/sysctl.d/99-fedora-optimize.conf
# Reduces swap usage (improves responsiveness)
vm.swappiness=10
# Increases tendency to keep inodes in cache
vm.vfs_cache_pressure=50
EOF
sysctl --system
