# Adwaita Dark Theme for CAVA

This configuration creates a beautiful Adwaita Dark theme for CAVA (Console Audio Visualizer) based on GNOME's default Adwaita theme colors.

## Features

- Uses official GNOME Adwaita Dark color palette
- Configured with ncurses output for broad compatibility  
- Enhanced smoothing for smooth visual experience
- Gradient colors based on Adwaita's accent colors:
  - Green: `#2EC27E`
  - Blue: `#1E78E4`
  - Purple: `#9841BB`
  - Cyan: `#0AB9DC`
  - Yellow: `#F5C211`
  - Red: `#C01C28`

## Files Included

- `config`: Main configuration file using Adwaita Dark theme
- `themes/adwaita_dark`: Theme definition file
- `shaders/adwaita_northern_lights.frag`: Custom shader (for when OpenGL is available)

## Requirements

- CAVA installed on your system
- For best results: a terminal that supports true colors

## Usage

Simply run `cava` and it will use the configuration from `~/.config/cava/config` automatically, applying the Adwaita Dark theme.

Alternatively, run: `cava -p ~/.config/cava/config`

## Controls

- Up/Down arrows: Adjust sensitivity
- Left/Right arrows: Adjust number of bars
- R: Reload config
- C: Reload colors only
- Q: Quit

## Notes

The configuration uses `ncurses` output method for maximum compatibility. If you have CAVA compiled with OpenGL support, you could switch to `sdl_glsl` method for even more impressive visuals with the custom shader.