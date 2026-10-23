# Xaess's Hyperland Dotfiles

These are the config files I use for my environment. 

<span style='color:orange'>** This is a work in progress.**<span>

I am learning to use and setup Hyperland. This repo will be updated as I learn. Read my configs and take what you need, if you have suggestion or tips, I will be happy to read them.

Once I am satisfied with these dotfiles I will apply them on a freshly installed system and adjust the scripts/configs to create a "one click" install script.

If you are a begginer like me, remember to **backup** your files before updating them. 

These dotfiles are comon to my laptop and my desktop. So there may be files and scripts you don't need.

## TODO

- Finish the `hyprwat` config to make it more coherent with waybar and use more features like wallpaper selector or workspace overview.
- Add/setup a theme to `kitty` so it's more coherent whith the system,
- Make all the buttons of the `swaync` config work with a full install/setup procedure.
- Update `install.sh` to make it look better and add an "install everything" option.
- A backup script.

## Components
<span style='color:green'>󰩐 </span> 󰁔 Finished, may change in the future.

<span style='color:orange'></span> 󰁔 In progress, or I am not satified yet and they will change soon.

### Available configs

- <span style='color:green'>󰩐 Hyperland</span>
- <span style='color:green'>󰩐 waybar</span>
- <span style='color:orange'> Hyprwat</span>
- <span style='color:orange'> Kitty</span>
- <span style='color:orange'> swaync</span>

### What you will need

- fish and [starship](https://starship.rs/)
- [waybar](https://github.com/Alexays/Waybar)
- [hyprwat](https://github.com/zackb/hyprwat)
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [swaync](https://github.com/ErikReider/SwayNotificationCenter), `swayos` and `swayosd-client`
- [mpvpaper](https://github.com/GhostNaN/mpvpaper) if you want to use a video as wallpaper. You can use [awww](https://codeberg.org/LGFae/awww) or [hyprpaper](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/) instead (<span style='color: orange'>and update `hypr/modules/autostart.lua`</span>).
- [wireplumber](https://pipewire.pages.freedesktop.org/wireplumber/)
- [hyprshot](https://github.com/Gustash/hyprshot) for screenshots 

### Icons and theme I use
- 󰇀 cursor : [Vimix cursors theme](https://www.gnome-look.org/p/1358330)
- 󰉋 icons : [Papirus](https://www.gnome-look.org/s/Gnome/p/1166289)
- 󰉦 theme : [Flat Remix GTK](https://www.gnome-look.org/p/1214931)

## Scripts

`install.sh` 󰁔 used to copy the dotfiles to the `~/.config` folder. <span style='color:red'>If ou want to use this script, make sure to have a `~/.config/hypr/modules/monitors.lua` file before runing it.</span>

`hypr/scripts/lid.sh` 󰁔 used to manage screens when closing/opening my laptop.

### Hyperland

```bash
./hypr
├── hyprland.lua                # main config file
├── modules
│   ├── autostart.lua           # apps runing at login
│   ├── binds.lua               # shortcuts
│   ├── decorations.lua         # layout, and widows decorations
│   ├── env.lua                 # cursors settings and other hyperland environments settings
│   ├── inputs.lua              # keyboard layout
│   ├── misc.lua                # wallpaper and other stuffs
│   ├── monitors.example.lua    # a config example for the monitor config
│   └── windowrules.lua         # widow rules
└── scripts
    └── lid.sh                  # script to manage screends when closing/opening my laptop
```

As explained before, if you want to use `install.sh` you need to make sure you have a `~/.config/modules/monitors.lua` file. Here is an example of what I use on my laptop:

```lua
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200@60",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "0x-1081",
    scale    = "1",
})

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@60",
    position = "1921x-1081",
    scale    = "1",
})
```
Run `hyprctl monitors` in your terminal to identify your screen, with available resolutions/framerate.

The `imputs.lua` installed with the script is the one I use. I made it because I have 2 keyboards with different layouts.
```lua
---------------
---- INPUT ----
---------------

-- default keyboard layout
hl.config({
    input = {
        kb_layout    = "gb",
        kb_variant   = "intl",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- this part is not necessary, this is for my second keyboard
for _, name in ipairs({
    "glorious-gmmk-3-(75%)",
    "glorious-gmmk-3-(75%)-keyboard",
}) do
    hl.device({ name = name, kb_layout = "us", kb_variant = "intl" })
end
```
Run `hyprctl devices` to identify your devices. 

### Hyprwat

```bash
./hyprwat
└── hyprwat.conf
```
### Kitty

```bash
./kitty
├── kitty.conf  # Config gile
└── theme.conf  # Theme config, needs to be setup
```

### Swaync

```bash
./swaync/
├── config.json         # main config
├── configSchema.json
└── style.css           # style file
```

### Waybar
```bash
./waybar/
├── config.jsonc                # main config file
├── groups
│   ├── apps.jsonc              # tray, wireplumber#sink and wireplumber#source, displayed on the left.
│   └── system.jsonc            # cpu, memory, disk, temperature and battery
├── launch.sh                   # reload script
├── modules                     # 1 config file per module
│   ├── clock.jsonc
│   ├── temperature.jsonc
│   ├── tray.jsonc
│   ├── wireplumber.jsonc
│   └── workspaces.jsonc
├── style.css                   # main style file
└── styles                      # 1 style file per group if needed
    ├── colors.css              # colors config
    ├── modules                 # 1 style file per module
    │   ├── battery.css
    │   ├── clock.css
    │   ├── cpu.css
    │   ├── disk.css
    │   ├── memory.css
    │   ├── temperature.css
    │   ├── tray.css
    │   ├── wireplumber.css
    │   └── workspaces.css
    └── system.css
```

## Important links

- [Hyperland github](https://github.com/hyprwm/hyprland)
- [Hyperland wiki](https://wiki.hypr.land/)
- [Nerdfonts](https://www.nerdfonts.com/cheat-sheet) 
- [Waybar wiki](https://github.com/Alexays/Waybar/wiki)
- [Swaync Github](https://github.com/ErikReider/SwayNotificationCenter#want-to-show-off-your-sick-config)
- [Notification tests](https://www.bennish.net/web-notifications.html)

