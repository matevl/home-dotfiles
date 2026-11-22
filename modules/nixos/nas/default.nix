{ lib, ... }: {
  imports = [
    ../core
    ../features
    ./networking.nix
    ./services.nix
  ];

  config.myNixosSettings = {
    docker.enable = lib.mkDefault true;
    jellyfin.enable = lib.mkDefault true;
    zfs.enable = lib.mkDefault true;
    tailscale.enable = lib.mkDefault true;
  };
}
