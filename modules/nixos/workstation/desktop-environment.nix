{
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = [
      pkgs.unstable.dux-shell
      pkgs.unstable.quickshell
    ];

    # Disable unnecessary default GNOME applications
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-console
      epiphany
      geary
      gnome-music
      gnome-calendar
      gnome-contacts
      gnome-maps
      gnome-weather
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  programs.niri.enable = true;
  services.desktopManager.gnome.enable = true;
}
