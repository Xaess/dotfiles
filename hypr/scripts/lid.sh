#!/bin/sh
INTERNAL="eDP-1"

internal_active() { hyprctl monitors | grep -q "^Monitor $INTERNAL"; }
external_count() { hyprctl monitors | grep '^Monitor' | grep -vc "$INTERNAL"; }
hood_closed() { busctl get-property org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager LidClosed | grep -q true; }
disable() { hyprctl eval "hl.monitor({ output = \"$INTERNAL\", disabled = true })"; }
activate() { hyprctl eval "hl.monitor({ output = \"$INTERNAL\", disabled = false })"; }

case "$1" in
close)
    sleep 1
    hood_closed || exit 0
    if [ "$(external_count)" -ge 1 ]; then
        internal_active && disable
    else
        systemctl suspend
    fi
    ;;
open)
    internal_active || activate
    ;;
sync)
    if hood_closed && [ "$(external_count)" -ge 1 ]; then
        internal_active && disable
    else
        internal_active || activate
    fi
    ;;
unplug)
    if hood_closed && [ "$(external_count)" -eq 0 ]; then
        internal_active || activate
        systemctl suspend
    fi
    ;;
esac
