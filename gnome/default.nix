{ config, pkgs, ... }:

let
  vars = import ../variables.nix;
  wallpaper = vars.wallpaper;
  lockWallpaper = vars.lockWallpaper;
in
{
  # Theme consistency (GNOME files/Nautilus will look good)
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  # Force dark mode for GNOME/GTK apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///${wallpaper}";
      picture-uri-dark = "file:///${wallpaper}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///${lockWallpaper}";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
    };
  };
}
