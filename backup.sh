#!/bin/bash
set -euo pipefail
SCRIPT_TITLE="Dotfiles Backup"
TIMESTAMP=$(date +%s)

mkdir -p backups/$TIMESTAMP

ask_menu() {
    local result
    # || true empêche set -e de tuer le script si Échap
    result=$(whiptail --title "$1" --menu "$2" "$3" "$4" "$5" \
        "${@:6}" 3>&1 1>&2 2>&3) || {
        echo -e "Annulé par l'utilisateur." >&2
        exit 0
    }
    echo -e "$result"
}

backup_everything() {
    echo "\e[33mBacking up every dotfile\e[0m"
    backup_hypr
    backup_waybar
    backup_hyprwat
    backup_kitty
    backup_swaync
    echo -e "\e[32m󰩐 Backup finished.\e[0m"
    tree backups/$TIMESTAMP
}

backup_hypr() {
    echo -e "\e[33m Backing up Hyperland.\e[0m"
    cp -r ~/.config/hypr/. backups/$TIMESTAMP/hypr
    echo -e "\e[32m󰩐 Hyperland backup finished.\e[0m"
    tree backups/$TIMESTAMP/hypr
}

backup_waybar() {
    echo -e "\e[33m Backing up waybar.\e[0m"
    cp -r ~/.config/waybar/. backups/$TIMESTAMP/waybar
    echo -e "\e[32m󰩐 waybar backup finished.\e[0m"
    tree backups/$TIMESTAMP/waybar
}

backup_hyprwat() {
    echo -e "\e[33m Backing up hyprwat.\e[0m"
    cp -r ~/.config/hyprwat/. backups/$TIMESTAMP/hyprwat
    echo -e "\e[32m󰩐 hyprwat backup finished.\e[0m"
    tree backups/$TIMESTAMP/hyprwat
}

backup_kitty() {
    echo -e "\e[33m Backing up kitty.\e[0m"
    cp -r ~/.config/kitty/. backups/$TIMESTAMP/kitty
    echo -e "\e[32m󰩐 kitty backup kitty.\e[0m"
    tree backups/$TIMESTAMP/kitty
}

backup_swaync() {
    echo -e "\e[33m Backing up swaync.\e[0m"
    cp -r ~/.config/swaync/. backups/$TIMESTAMP/swaync
    echo -e "\e[32m󰩐 swaync backup swaync.\e[0m"
    tree backups/$TIMESTAMP/swaync
}

COMPONENT=$(ask_menu "Config manager" "Select component to install" 18 78 7 \
    "1" "everything" \
    "2" "hypr" \
    "3" "waybar" \
    "4" "hyprwat" \
    "5" "kytty" \
    "6" "swaync" \
    "0" "Quit")

case $COMPONENT in
1) backup_everything ;;
2) backup_hypr ;;
3) backup_waybar ;;
4) backup_hyprwat ;;
5) backup_kitty ;;
6) backup_swaync ;;
0)
    echo -e "Bye !"
    exit 0
    ;;
*)
    echo "Sorry, what did you mean? $COMPONENT" >&2
    exit 1
    ;;
esac
