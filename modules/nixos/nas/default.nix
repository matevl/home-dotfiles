{ lib, ... }: {
  imports = [
    ../core
    ../features
    ./services.nix
  ];

  config.myNixosSettings = {
    jellyfin.enable = lib.mkDefault true;
    zfs.enable = lib.mkDefault true;
    tailscale.enable = lib.mkDefault true;
  };
}
