# Mat's NixOS Configuration

This repository contains my personal **NixOS 26.05** configuration, managed with **Flakes** and **Home Manager**.

## Desktop Environments

This config uses **Niri** as the main compositor, with **Quickshell** and **DMS** as the desktop layer. **GNOME** is kept as a backup desktop, and GDM handles login.

## Included Tools

The user environment includes **VS Code**, **Helix**, **zsh**, **Kitty**, **Brave**, and a set of developer tools for **Nix**, **Rust**, **Python**, **C/C++**, and **Godot**.

## Layout

- `hosts/`: host-specific NixOS configuration.
- `modules/nixos/`: system-level configuration.
- `modules/home-manager/`: user environment and application settings.
- `wallpapers/`: wallpapers used by the desktop setup.

## Usage

Apply the configuration on the laptop with:

```bash
sudo nixos-rebuild switch --flake .#laptop
```
