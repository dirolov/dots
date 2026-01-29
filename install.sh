#!/bin/bash

# Dotfiles installer script
# Usage: ./install.sh [install|uninstall]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Package lists
MAIN_PACKAGES=(
    "sway" "waybar" "fish" "kitty" "fuzzel" "mako" "thunar" "micro" "python-pywal16"
    "cava" "fastfetch" "lsd" "most" "fzf"
    "ttf-google-fonts-git" "nerd-fonts"
    "xdg-desktop-portal-wlr" "mate-polkit" "sway-alttab-gui" "xwayland-satellite"
)

AUR_PACKAGES=(
    "yt-dlp" "gradience" "walogram-git"
)

# Config directories to copy/remove
CONFIG_DIRS=(
    "sway" "waybar" "fish" "fuzzel" "mako" "cava" "fastfetch" "wal" "presets"
)

install_packages() {
    echo "Installing main packages..."
    yay -S --needed "${MAIN_PACKAGES[@]}"
    
    echo "Installing AUR packages..."
    yay -S --needed "${AUR_PACKAGES[@]}"
}

uninstall_packages() {
    echo "Removing AUR packages..."
    yay -Rns "${AUR_PACKAGES[@]}" 2>/dev/null || true
    
    echo "Removing main packages..."
    yay -Rns "${MAIN_PACKAGES[@]}" 2>/dev/null || true
}

install_configs() {
    echo "Installing configuration files..."
    
    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Copy config directories
    for dir in "${CONFIG_DIRS[@]}"; do
        if [ -d "$SCRIPT_DIR/.config/$dir" ]; then
            echo "Installing $dir config..."
            cp -r "$SCRIPT_DIR/.config/$dir" "$CONFIG_DIR/"
        fi
    done
    
    # Copy pywal16-libadwaita
    if [ -d "$SCRIPT_DIR/pywal16-libadwaita" ]; then
        echo "Installing pywal16-libadwaita..."
        cp -r "$SCRIPT_DIR/pywal16-libadwaita" "$HOME/"
        cd "$HOME/pywal16-libadwaita"
        make install
    fi
    
    # Set fish as default shell
    echo "Setting fish as default shell..."
    chsh -s /usr/bin/fish
    
    echo "Configuration installed successfully!"
    echo "Please log out and log back in to use fish shell."
    echo "Run 'wal-choose' to set up your wallpaper and theme."
}

uninstall_configs() {
    echo "Removing configuration files..."
    
    # Remove config directories
    for dir in "${CONFIG_DIRS[@]}"; do
        if [ -d "$CONFIG_DIR/$dir" ]; then
            echo "Removing $dir config..."
            rm -rf "$CONFIG_DIR/$dir"
        fi
    done
    
    # Remove pywal16-libadwaita
    if [ -d "$HOME/pywal16-libadwaita" ]; then
        echo "Removing pywal16-libadwaita..."
        rm -rf "$HOME/pywal16-libadwaita"
    fi
    
    # Remove pywal cache
    if [ -d "$HOME/.cache/wal" ]; then
        echo "Removing pywal cache..."
        rm -rf "$HOME/.cache/wal"
    fi
    
    # Reset shell to bash
    echo "Resetting shell to bash..."
    chsh -s /bin/bash
    
    echo "Configuration removed successfully!"
}

show_help() {
    echo "Dotfiles installer for Sway + Waybar + Fish + Pywal environment"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  install     Install packages and configuration files"
    echo "  uninstall   Remove packages and configuration files"
    echo "  help        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 install    # Install everything"
    echo "  $0 uninstall  # Remove everything"
}

main() {
    case "${1:-}" in
        "install")
            echo "Installing dotfiles..."
            install_packages
            install_configs
            ;;
        "uninstall")
            echo "Uninstalling dotfiles..."
            read -p "Are you sure you want to remove all packages and configs? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                uninstall_configs
                uninstall_packages
            else
                echo "Uninstall cancelled."
            fi
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo "Error: Unknown command '${1:-}'"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"
