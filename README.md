# Mat's NixOS Configuration

This repository contains my personal NixOS configuration, managed with **Flakes** and **Home Manager**.

## 🖥️ Desktop Environments

I use a dual-setup strategy to separate mindsets:
* **Sway (Wayland):** My primary environment for **Work**. Minimal, fast, and keyboard-driven.
* **GNOME:** My environment for **Chill**. Stable and distraction-free.

## 🛠️ Status
⚠️ **Work in Progress (WIP)** The configuration is constantly evolving as I refine my workflow.

## 🚀 Quick Apply
To apply this configuration on the laptop:
```bash
sudo nixos-rebuild switch --flake .#name
```
