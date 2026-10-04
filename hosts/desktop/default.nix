{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = config.mySettings.hostName;

  mySettings.game.enable = true;
  mySettings.nvidia.enable = true;
}
