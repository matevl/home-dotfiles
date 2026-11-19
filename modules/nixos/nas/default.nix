{ lib, ... }: {
  imports = [
    ../core
    ../features
    ./services.nix
  ];

  config.myNixosSettings.jellyfin.enable = lib.mkDefault true;
}
