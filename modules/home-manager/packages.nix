{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Apps ---
    pkgs.unstable.deezer-desktop
    nautilus
    vlc
    resources
    pkgs.unstable.moonlight-qt
    transmission_4-gtk

    # --- General tools ---
    ngrok

    # --- Shell tools ---
    screen
    mutagen

    # --- Code tools ---
    # C/C++
    gnumake
    cmake
    clang-tools

    # Rust
    rustc
    cargo
    rustfmt
    clippy

    # Python
    python3

    # JS/TS
    yarn

    # NIX
    nix
    nixfmt-tree
    nixd
    nix-tree
    deadnix

    # Game engines
    pkgs.unstable.godot_4
    pkgs.unstable.gdtoolkit_4

    # Git tools
    pre-commit
    github-desktop

    # --- Windows managers tools ---
    nerd-fonts.jetbrains-mono
    wl-clipboard
    gnome-screenshot
    xwayland-satellite

    # --- Multimedia controls ---
    brightnessctl
    pavucontrol

    # --- App utils ---
    desktop-file-utils
  ];
}
