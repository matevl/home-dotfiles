{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.niri.enable = true;

  # Disable unnecessary default GNOME applications
  environment.gnome.excludePackages = with pkgs; [
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

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = false;
  };
}
