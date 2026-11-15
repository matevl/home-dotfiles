{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = config.mySettings.hostName;

  mySettings.stateVersion = "26.05";
  mySettings.game.enable = true;
  mySettings.nvidia = {
    enable = true;
    modern.enable = true;
  };
}
