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
    bitwarden-desktop

    # Game engines
    pkgs.unstable.godot_4
    pkgs.unstable.gdtoolkit_4

    # Git tools
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
