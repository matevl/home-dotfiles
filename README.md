# Mat's NixOS Configuration

This repository contains my personal NixOS configuration, managed with **Flakes** and **Home Manager**.

## 🖥️ Desktop Environments

I use a dual-setup strategy to separate mindsets:
* **Niri (Wayland):** My primary environment for **Work**. A scrollable-tiling window manager, fast and keyboard-driven, integrated with DankMaterialShell.
* **GNOME:** My environment for **Chill**. Stable and distraction-free.

## 🛠️ Status
⚠️ **Work in Progress (WIP)** The configuration is constantly evolving as I refine my workflow.

## 📁 Architecture

A clean and simple overview of the repository structure:

*   **`hosts/`**: Hardware-specific configurations for my different devices.
*   **`modules/nixos/`**: Core system configuration, memory management, and system-level settings.
*   **`modules/home-manager/`**: My personal environment, including browsers, small binaries, and application settings.
*   **`wallpapers/`**: A basic set of wallpapers that I use across my devices.

## 🚀 Quick Apply
To apply this configuration on the laptop:
```bash
sudo nixos-rebuild switch --flake .#name
```
