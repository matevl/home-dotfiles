{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = config.myNixosSettings.hostName;

  myNixosSettings = {
    game.enable = true;
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
