{ lib, ... }:
{
  options.myHomeSettings = {
    desktopEnvironmentConfig.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable custom DE/WM dotfiles (Niri, GNOME, Hyprland)";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "Home Manager release this user environment was first installed with. Never change it after install.";
    };
  };
}
