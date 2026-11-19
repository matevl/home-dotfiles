{ config, ... }: {
  imports = [
    ./boot.nix
    ./local.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./packages.nix
    ../options.nix
  ];

  system.stateVersion = config.myNixosSettings.stateVersion;
}
