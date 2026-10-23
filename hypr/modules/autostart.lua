-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("mpvpaper -o \"--input-ipc-server=/tmp/mpvsocket no-audio loop hwdec=auto auto-pause panscan=1.0\" '*' ~/Videos/_BG.mp4")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("waybar")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("sleep 3 && protonvpn-app")
	hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/lid.sh sync")
end)
