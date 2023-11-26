#!/bin/sh

WG_CONF="/etc/wireguard/wg0.conf"

if [ ! -f "$WG_CONF" ]; then
    echo "Конфигурационный файл WireGuard не найден: $WG_CONF"
    exit 1
fi

wg-quick up wg0

trap 'wg-quick down wg0; exit 0' SIGTERM SIGINT

while true; do
    sleep 60
done
