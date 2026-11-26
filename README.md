# Mat's NixOS Configuration

This repository contains my personal **NixOS** configuration, managed with **Flakes** and **Home Manager**.

## Hosts & Profiles

- **Workstations (`laptop`, `desktop`)**: Desktop environment built around **Niri** (with **Quickshell**, **Dux-Shell**, and **GNOME** as a fallback) alongside a full development setup.
- **NAS (`nas`)**: Headless storage and self-hosted server built on **ZFS**, **Tailscale**, and **Docker**, exposed behind **Caddy** and **Tinyauth**.

## Layout

- `hosts/`: host-specific NixOS configurations (`laptop`, `desktop`, `nas`, and `_template/`).
- `modules/nixos/`: system-level modules split into `core/`, `features/`, `workstation/`, and `nas/`.
- `modules/home-manager/`: user environment split into `core/` and `workstation/`.

## Usage

Apply a configuration to a host (e.g., `laptop`, `desktop`, or `nas`):

```bash
sudo nixos-rebuild switch --flake .#<hostname>