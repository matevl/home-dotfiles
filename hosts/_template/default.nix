{ config, ... }:

{
  imports = [
    ../../modules/nixos/core
    ../../modules/nixos/features
    ./hardware-configuration.nix
  ];

  networking.hostName = config.myNixosSettings.hostName;

  myNixosSettings = {
    username = "template";
    stateVersion = "26.05";
  };

  home-manager.sharedModules = [
    {
      myHomeSettings = {
        stateVersion = "26.05";
      };
    }
  ];
}
