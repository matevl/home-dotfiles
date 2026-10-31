{
  pkgs,
  ...
}:
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
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
    };
    "org/gnome/mutter" = {
      check-alive-timeout = 10000;
    };
  };
}
