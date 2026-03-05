#!/usr/bin/env bash
##############################################
#   ABYSS RICE — Auto Install Script
#   Arch Linux + Hyprland
##############################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'
BOLD='\033[1m'

print_header() {
    echo ""
    echo -e "${BLUE}${BOLD}══════════════════════════════════════${NC}"
    echo -e "${BLUE}${BOLD}   ABYSS RICE — Hyprland Setup         ${NC}"
    echo -e "${BLUE}${BOLD}══════════════════════════════════════${NC}"
    echo ""
}

print_step() { echo -e "\n${CYAN}${BOLD}▶ $1${NC}"; }
print_ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
print_warn() { echo -e "  ${YELLOW}⚠${NC} $1"; }
print_err()  { echo -e "  ${RED}✗${NC} $1"; }

# ── CHECK AUR HELPER ─────────────────────
check_aur() {
    if command -v paru &>/dev/null; then
        AUR="paru"
    elif command -v yay &>/dev/null; then
        AUR="yay"
    else
        print_err "No AUR helper found! Install paru or yay first."
        echo -e "\n  Install paru:"
        echo -e "  ${YELLOW}git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si${NC}"
        exit 1
    fi
    print_ok "Using: $AUR"
}

# ── PACKAGES ─────────────────────────────
PACMAN_PKGS=(
    # ── Wayland Core
    hyprland
    hyprpaper
    hyprlock
    hypridle
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    qt5-wayland
    qt6-wayland
    polkit-gnome

    # ── Bar & Launcher
    waybar
    rofi-wayland
    rofi-emoji

    # ── Terminal & Shell
    kitty
    starship
    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting

    # ── File Manager
    thunar
    thunar-volman
    thunar-archive-plugin
    gvfs
    tumbler
    ffmpegthumbnailer

    # ── Notifications
    dunst
    libnotify

    # ── Audio
    pipewire
    pipewire-alsa
    pipewire-audio
    pipewire-jack
    pipewire-pulse
    wireplumber
    pavucontrol
    playerctl

    # ── Network
    networkmanager
    network-manager-applet
    nm-connection-editor

    # ── Bluetooth
    bluez
    bluez-utils
    blueman

    # ── Screenshot
    grim
    slurp
    swappy
    wl-clipboard

    # ── Clipboard Manager
    cliphist

    # ── Fonts
    ttf-jetbrains-mono-nerd
    ttf-nerd-fonts-symbols
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk

    # ── Icons
    papirus-icon-theme

    # ── GTK Theme
    adw-gtk3
    gtk4

    # ── Brightness
    brightnessctl

    # ── System Tools
    btop
    fastfetch
    bat
    eza
    fd
    ripgrep
    fzf
    zoxide

    # ── Image Viewer
    swayimg

    # ── Misc
    xdg-utils
    dbus
    xwayland
    wlroots
)

AUR_PKGS=(
    # ── Cursor
    bibata-cursor-theme

    # ── Logout Menu
    wlogout

    # ── GTK Configuration
    nwg-look

    # ── Hyprland plugins/extras
    hyprshot
    hyprcursor

    # ── Additional
    yazi          # TUI file manager
    lazygit       # Git TUI
    mission-center # System monitor (GTK4)
)

print_header

# ── STEP 1: Check AUR ────────────────────
print_step "Checking AUR helper"
check_aur

# ── STEP 2: Update System ─────────────────
print_step "Updating system"
sudo pacman -Syu --noconfirm
print_ok "System updated"

# ── STEP 3: Install pacman packages ──────
print_step "Installing core packages (pacman)"
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}" 2>/dev/null
print_ok "Core packages installed"

# ── STEP 4: Install AUR packages ─────────
print_step "Installing AUR packages ($AUR)"
$AUR -S --needed --noconfirm "${AUR_PKGS[@]}" 2>/dev/null
print_ok "AUR packages installed"

# ── STEP 5: Deploy configs ────────────────
print_step "Deploying dotfiles"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

declare -A CONFIG_MAP=(
    ["hypr"]="$CONFIG/hypr"
    ["waybar"]="$CONFIG/waybar"
    ["rofi"]="$CONFIG/rofi"
    ["kitty"]="$CONFIG/kitty"
    ["dunst"]="$CONFIG/dunst"
    ["wlogout"]="$CONFIG/wlogout"
    ["gtk-3.0"]="$CONFIG/gtk-3.0"
    ["gtk-4.0"]="$CONFIG/gtk-4.0"
    ["starship"]="$HOME"
)

for src in "${!CONFIG_MAP[@]}"; do
    dest="${CONFIG_MAP[$src]}"
    mkdir -p "$dest"
    if [ "$src" = "starship" ]; then
        cp "$DOTFILES_DIR/starship/starship.toml" "$dest/.config/starship.toml" 2>/dev/null || \
        cp "$DOTFILES_DIR/starship/starship.toml" "$CONFIG/starship.toml" 2>/dev/null || true
    else
        cp -r "$DOTFILES_DIR/$src/." "$dest/"
    fi
    print_ok "Deployed: $src → $dest"
done

# Make scripts executable
chmod +x "$CONFIG/waybar/scripts/"*.py 2>/dev/null || true

# ── STEP 6: Wallpaper dir ─────────────────
print_step "Setting up wallpaper"
mkdir -p "$CONFIG/hypr/wallpapers"
print_warn "Add your wallpaper to: $CONFIG/hypr/wallpapers/wallpaper.jpg"
print_warn "Then run: hyprpaper"

# ── STEP 7: Shell setup ───────────────────
print_step "Configuring Zsh + Starship"

if [ ! -f "$HOME/.zshrc" ] || ! grep -q "starship" "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOF'

# ── Abyss Rice — Shell Config ─────────────

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init zsh)"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Aliases — eza (modern ls)
alias ls='eza --icons=always --group-directories-first'
alias la='eza -la --icons=always --group-directories-first --git'
alias lt='eza --tree --icons=always -L 2'
alias ll='eza -l --icons=always --group-directories-first --git'

# Aliases — bat (better cat)
alias cat='bat --style=auto'

# Aliases — misc
alias gs='lazygit'
alias vi='nvim'
alias vim='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias clip='wl-copy'
alias yf='yazi'

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf integration
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="
    --color=bg+:#1d2740,bg:#070b14,spinner:#4d9fff,hl:#4d9fff
    --color=fg:#c8d8f8,header:#7a8aaa,info:#a57fff,pointer:#4d9fff
    --color=marker:#4dffb4,fg+:#c8d8f8,prompt:#4d9fff,hl+:#4dffb4
    --border rounded --height 40% --layout reverse --info inline"

# Env vars
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export TERMINAL=kitty
EOF
    print_ok "Zsh config appended"
fi

# ── STEP 8: Enable services ───────────────
print_step "Enabling system services"
sudo systemctl enable --now NetworkManager 2>/dev/null && print_ok "NetworkManager enabled"
sudo systemctl enable --now bluetooth 2>/dev/null && print_ok "Bluetooth enabled"
systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null && print_ok "PipeWire enabled"

# ── STEP 9: Set default shell ─────────────
print_step "Setting Zsh as default shell"
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    print_ok "Zsh set as default shell (re-login required)"
else
    print_ok "Zsh already default shell"
fi

# ── DONE ─────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}══════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}   ✓  ABYSS RICE INSTALLED SUCCESSFULLY!   ${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════${NC}"
echo ""
echo -e " ${BOLD}Next steps:${NC}"
echo -e "  1. ${CYAN}Add wallpaper${NC} → ${YELLOW}~/.config/hypr/wallpapers/wallpaper.jpg${NC}"
echo -e "  2. ${CYAN}Set cursor${NC}   → run ${YELLOW}nwg-look${NC} and select Bibata-Modern-Classic"
echo -e "  3. ${CYAN}Set GTK theme${NC}→ select ${YELLOW}adw-gtk3-dark${NC} in nwg-look"
echo -e "  4. ${CYAN}Log out${NC} and select ${YELLOW}Hyprland${NC} from your display manager"
echo -e "  5. Press ${YELLOW}SUPER + R${NC} to launch Rofi (app launcher)"
echo -e "  6. Press ${YELLOW}SUPER + Return${NC} to open Kitty terminal"
echo ""
echo -e " ${PURPLE}Keybinds:${NC}"
echo -e "  ${BOLD}SUPER + R${NC}      → Rofi launcher"
echo -e "  ${BOLD}SUPER + Return${NC} → Kitty terminal"
echo -e "  ${BOLD}SUPER + E${NC}      → Thunar files"
echo -e "  ${BOLD}SUPER + Q${NC}      → Close window"
echo -e "  ${BOLD}SUPER + Escape${NC} → Lock screen"
echo -e "  ${BOLD}SUPER + SHIFT + Q${NC} → Logout menu"
echo -e "  ${BOLD}Print Screen${NC}   → Screenshot area"
echo -e "  ${BOLD}SUPER + V${NC}      → Clipboard history"
echo ""
