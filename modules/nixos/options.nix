{ lib, ... }:

{
  options.mySettings = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "mat";
      description = "Default username";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "System hostname";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Paris";
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
    };
    keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "fr";
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "/home/mat/home-dotfiles/wallpapers/main_wallpaper.png";
    };
    lockWallpaper = lib.mkOption {
      type = lib.types.str;
      default = "/home/mat/home-dotfiles/wallpapers/lock_wallpaper.png";
    };
    game = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Steam, Proton, and gaming optimizations";
      };
    };
  };
}
