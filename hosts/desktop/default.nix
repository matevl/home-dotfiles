{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../../modules/nixos/workstation
    ./hardware-configuration.nix
  ];

  networking.hostName = config.myNixosSettings.hostName;

  myNixosSettings = {
    game = {
      enable = true;
      remote.enable = true;
    };
    ldmtool.enable = true;
    nvidia = {
      enable = true;
      modern.enable = true;
    };
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
