#!/bin/bash
set -euo pipefail
SCRIPT_TITLE="Dotfiles Installer"
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

COMPONENT=$(ask_menu "Config manager" "Select component to install" 18 78 7 \
    "1" everything \
    "2" "hypr" \
    "3" "waybar" \
    "4" "hyprwat" \
    "5" "kytty" \
    "6" "swaync" \
    "0" "Quit")

isntall_everything() {
    echo -e "\e[33mInstalling every dotfile\e[0m"
    isntall_hypr
    isntal_waybar
    install_hyprwat
    install_kitty
    install_swaync
    echo -e "\e[32m󰩐 Installation  finished.\e[0m"
}

install_hypr() {
    echo -e "\e[33m Installing hyperland configurations.\e[0m"
    cp -r "hypr/." "$HOME/.config/hypr/"
    rm "$HOME/.config/hypr/modules/monitors.lua"
    hyprctl configerrors
    echo -e "\e[32m󰩐 hyperland configurations installed !\e[0m"
}

install_waybar() {
    echo -e "\e[33m Installing waybar configurations.\e[0m"
    rm -Rf ~/.config/waybar
    mkdir ~/.config/waybar
    cp -r ./waybar/. ~/.config/waybar
    echo -e "\e[32m󰩐 waybar configurations installed !\e[0m"
    sh ~/.config/waybar/launch.sh
    echo -e "\e[32m󰩐 Restarted waybar"
}

install_hyprwat() {
    echo -e "\e[33m Installing hyprwat configurations.\e[0m"
    rm -Rf ~/.config/hyprwat
    mkdir ~/.config/hyprwat
    cp -r ./hyprwat/. ~/.config/hyprwat
    echo -e "\e[32m󰩐 hyprwat configurations installed !\e[0m"
}

install_kitty() {
    echo -e "\e[33m Installing kitty configurations.\e[0m"
    rm -Rf ~/.config/kitty
    mkdir ~/.config/kitty
    cp -r ./kitty/. ~/.config/kitty
    echo -e "\e[32m󰩐 kitty configurations installed !\e[0m"
}

install_swaync() {
    echo -e "\e[33m Installing swaync configurations.\e[0m"
    rm -Rf ~/.config/swaync
    mkdir ~/.config/swaync
    cp -r ./swaync/. ~/.config/swaync
    echo -e "\e[32m󰩐 swaync configurations installed !\e[0m"
}

case $COMPONENT in
1) isntall_everything ;;
2) install_hypr ;;
3) install_waybar ;;
4) install_hyprwat ;;
5) install_kitty ;;
6) install_swaync ;;
0)
    echo -e "Bye !"
    exit 0
    ;;
*)
    echo "Sorry, what did you mean? $COMPONENT" >&2
    exit 1
    ;;
esac
