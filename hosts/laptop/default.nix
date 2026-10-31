{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    ../../modules/nixos
  ];

  networking.hostName = config.mySettings.hostName;

  mySettings.stateVersion = "26.05";
  mySettings.game.enable = true;
}
