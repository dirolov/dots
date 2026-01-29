#!/bin/bash

# Function to detect if we're on Wayland
is_wayland() {
    [[ -n "$WAYLAND_DISPLAY" || "$XDG_SESSION_TYPE" == "wayland" ]]
}

get_layout() {
    # For Wayland Sway - prioritize swaymsg
    if is_wayland && command -v swaymsg >/dev/null 2>&1; then
        # Get the layout from the first keyboard that has a non-null layout
        layout=$(swaymsg -t get_inputs 2>/dev/null | jq -r '.[] | select(.type == "keyboard") | .xkb_active_layout_name' 2>/dev/null | grep -v null | head -n1)

        if [[ -n "$layout" && "$layout" != "null" ]]; then
            if [[ "$layout" == *"English (US)"* ]]; then
                echo "US"
            elif [[ "$layout" == *"Russian"* ]]; then
                echo "RU"
            else
                # Fallback for other layouts - just take the first part before the first space
                echo "${layout%% *}"
            fi
            return
        fi
    fi

    # For Wayland Hyprland
    if is_wayland && command -v hyprctl >/dev/null 2>&1; then
        keyboard_layout=$(hyprctl devices -j 2>/dev/null | jq -r '.keyboards[].active_keymap' 2>/dev/null | head -n1)
        if [[ -n "$keyboard_layout" ]]; then
            if [[ "$keyboard_layout" == *"us"* ]] || [[ "$keyboard_layout" == *"US"* ]]; then
                echo "US"
            elif [[ "$keyboard_layout" == *"ru"* ]] || [[ "$keyboard_layout" == *"RU"* ]]; then
                echo "RU"
            else
                echo "${keyboard_layout^^}"
            fi
            return
        fi
    fi

    # Fallback: try setxkbmap for X11 environments
    if command -v setxkbmap >/dev/null 2>&1; then
        layout=$(setxkbmap -query 2>/dev/null | grep layout | head -n1 | awk '{print $2}' | cut -d',' -f1)

        if [[ -n "$layout" ]]; then
            if [[ "$layout" == *"us"* ]]; then
                echo "US"
            elif [[ "$layout" == *"ru"* ]]; then
                echo "RU"
            else
                echo "${layout^^}"
            fi
            return
        fi
    fi

    # Final fallback
    echo "??"
}

case "$1" in
    --get)
        result=$(get_layout)
        echo "$result"
        ;;
    --switch)
        if is_wayland && command -v swaymsg >/dev/null 2>&1; then
            # Sway
            swaymsg input "*" xkb_switch_layout next >/dev/null 2>&1
        elif is_wayland && command -v hyprctl >/dev/null 2>&1; then
            # Hyprland
            hyprctl dispatch kb_input_switch_layout
        else
            # X11
            if command -v setxkbmap >/dev/null 2>&1; then
                current_layouts=$(setxkbmap -query 2>/dev/null | grep layout | head -n1 | awk '{print $2}')

                if [[ "$current_layouts" == *"ru"* ]] || [[ "$current_layouts" == *",ru"* ]]; then
                    setxkbmap -layout us,ru -option grp:alt_shift_toggle
                else
                    setxkbmap -layout ru,us -option grp:alt_shift_toggle
                fi
            fi
        fi
        ;;
    *)
        # Return JSON for waybar
        result=$(get_layout)
        echo "{\"text\":\"$result\", \"tooltip\":\"Current layout: $result. Click to switch.\"}"
        ;;
esac