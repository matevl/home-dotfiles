{ lib, ... }: {
  imports = [
    ../core
    ../features
  ];

  config.myNixosSettings.jellyfin.enable = lib.mkDefault true;
}
