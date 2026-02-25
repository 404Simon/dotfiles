#!/usr/bin/env bash

DNS_CONFIG="/etc/NetworkManager/conf.d/olm-dns.conf"
PANGOLIN_STATUS=$(pangolin status 2>&1)

if [[ -f "$DNS_CONFIG" ]]; then
    echo "Pangolin is down but DNS config persists. Cleaning up..."
    sudo rm $DNS_CONFIG
    sudo nmcli general reload dns-full
    sudo systemctl reload NetworkManager

    echo "Cleanup complete."
else
    echo "Everything is fine."
fi
