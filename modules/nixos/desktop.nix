{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      # -- X11 / Wayland --
      xkb = {
        layout = config.mySettings.keyboardLayout;
        variant = "";
      };
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse = {
        enable = true;
      };
      wireplumber.enable = true;
    };

    blueman.enable = true;

  };
  programs.niri.enable = true;

  environment = {
    systemPackages = [
      pkgs.unstable.dms-shell
      pkgs.unstable.quickshell
    ];

    # Disable unnecessary default GNOME applications
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-console
      epiphany # Web browser
      geary # Mail client
      gnome-music
      gnome-calendar
      gnome-contacts
      gnome-maps
      gnome-weather
      totem # Video player
    ];
  };
}
