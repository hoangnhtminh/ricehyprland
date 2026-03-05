# 🌑 ABYSS RICE — Hyprland Dotfiles

> Ultra-lightweight, beautiful Arch Linux rice with custom **Abyss** dark theme.

---

## 🖥️ Stack

| Component     | Package           | Role                    |
|--------------|-------------------|-------------------------|
| **WM**        | Hyprland          | Wayland compositor      |
| **Bar**       | Waybar            | Status bar              |
| **Launcher**  | Rofi              | App launcher / menus    |
| **Terminal**  | Kitty             | GPU-accelerated terminal|
| **Files**     | Thunar            | File manager (GTK)      |
| **Notifs**    | Dunst             | Notification daemon     |
| **Wallpaper** | Hyprpaper         | Wayland wallpaper       |
| **Lock**      | Hyprlock          | Screen locker           |
| **Idle**      | Hypridle          | Power management        |
| **Shell**     | Zsh + Starship    | Terminal prompt         |
| **Icons**     | Papirus-Dark      | Icon theme              |
| **Cursor**    | Bibata-Modern-Classic | Mouse cursor        |
| **GTK**       | adw-gtk3-dark     | GTK3/4 theme            |
| **Logout**    | wlogout           | Power menu              |
| **Clipboard** | cliphist          | Clipboard history       |

---

## 🎨 Color Palette — Abyss

```
Base       #070b14    Deep navy black
Surface    #0e1421    Card backgrounds
Elevated   #1d2740    Elevated elements
Border     #2a3a5c    Borders & separators
Text       #c8d8f8    Primary text
Dim        #7a8aaa    Secondary text

Blue       #4d9fff    Primary accent (borders, active)
Purple     #a57fff    Secondary accent (gradients)
Cyan       #00d4ff    Tertiary accent (info)
Green      #4dffb4    Success / git add
Red        #ff4d6a    Error / critical
Yellow     #ffd700    Warning / git dirty
Orange     #ff9a3c    Rust / caution
```

---

## 📦 Additional Extensions & Tools

### Included
- **cliphist** — Clipboard manager with rofi integration (`SUPER+V`)
- **swappy** — Screenshot annotation tool
- **grim + slurp** — Wayland screenshot utilities
- **playerctl** — Media playback control (Waybar media module)
- **brightnessctl** — Backlight control (Waybar + keybinds)
- **btop** — Beautiful system monitor (click CPU/RAM in Waybar)
- **fastfetch** — System info display
- **eza** — Modern `ls` replacement with icons
- **bat** — Syntax-highlighted `cat`
- **fd** — Fast `find` replacement
- **ripgrep** — Fast `grep` replacement
- **fzf** — Fuzzy finder (Ctrl+R for history, Ctrl+T for files)
- **zoxide** — Smarter `cd` with frecency
- **yazi** — Blazing-fast TUI file manager
- **lazygit** — Git TUI
- **starship** — Cross-shell prompt with Abyss colors

### Recommended additions
```bash
# Browser
paru -S firefox

# Editor  
paru -S neovim

# Music
paru -S spotify

# Image viewer
paru -S swayimg

# QT theming
paru -S qt5ct qt6ct kvantum

# Fonts (extra)
paru -S ttf-fira-code ttf-cascadia-code-nerd
```

---

## 🚀 Installation

### Automatic
```bash
git clone <your-repo> ~/rice-abyss
cd ~/rice-abyss
chmod +x install.sh
./install.sh
```

### Manual
```bash
# Copy configs
cp -r hypr/         ~/.config/hypr/
cp -r waybar/       ~/.config/waybar/
cp -r rofi/         ~/.config/rofi/
cp -r kitty/        ~/.config/kitty/
cp -r dunst/        ~/.config/dunst/
cp -r wlogout/      ~/.config/wlogout/
cp -r gtk-3.0/      ~/.config/gtk-3.0/
cp    starship/starship.toml ~/.config/starship.toml

# Make scripts executable
chmod +x ~/.config/waybar/scripts/*.py
```

---

## ⌨️ Keybindings

### Applications
| Key | Action |
|-----|--------|
| `SUPER + Return` | Terminal (Kitty) |
| `SUPER + E` | File Manager (Thunar) |
| `SUPER + R` | App Launcher (Rofi) |
| `SUPER + B` | Browser |
| `SUPER + .` | Emoji Picker |
| `SUPER + V` | Clipboard History |

### Windows
| Key | Action |
|-----|--------|
| `SUPER + Q` | Close window |
| `SUPER + F` | Fullscreen |
| `SUPER + SHIFT+F` | Fake fullscreen |
| `SUPER + Space` | Toggle float |
| `SUPER + H/L/K/J` | Move focus |
| `SUPER + SHIFT+H/L/K/J` | Move window |

### Workspaces
| Key | Action |
|-----|--------|
| `SUPER + 1-9` | Switch workspace |
| `SUPER + SHIFT+1-9` | Move to workspace |
| `SUPER + Tab` | Next workspace |
| `SUPER + S` | Toggle scratchpad |

### Screenshot
| Key | Action |
|-----|--------|
| `Print` | Area screenshot → swappy |
| `SUPER + Print` | Full screenshot → swappy |
| `SUPER + SHIFT+Print` | Area to clipboard |

### System
| Key | Action |
|-----|--------|
| `SUPER + Escape` | Lock screen |
| `SUPER + SHIFT+Q` | Logout menu |
| `SUPER + CTRL+Escape` | Hyprland exit |

---

## 🔧 Post-install

1. **Wallpaper** — Place at `~/.config/hypr/wallpapers/wallpaper.jpg`
2. **Cursor** — Run `nwg-look`, select `Bibata-Modern-Classic`
3. **GTK Theme** — Run `nwg-look`, select `adw-gtk3-dark`
4. **Neovim** — Recommend [LazyVim](https://lazyvim.org) with Abyss-compatible colorscheme
5. **QT Apps** — Run `qt6ct` and set theme to match

---

## 📊 RAM Usage (Idle)

| Process | ~RAM |
|---------|------|
| Hyprland | ~80MB |
| Waybar | ~35MB |
| Dunst | ~5MB |
| Hyprpaper | ~20MB |
| Kitty | ~30MB |
| **Total idle** | **~170-200MB** |

> Extremely lightweight — far below most DEs (GNOME: 800MB+, KDE: 400MB+)

---

*Made with 💙 — Abyss Theme*
