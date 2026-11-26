{ config, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../../modules/nixos/nas
    ./hardware-configuration.nix
  ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.r8168 ];
    blacklistedKernelModules = [ "r8169" ];
    kernelParams = [
      "pcie_aspm=off"
    ];
  };

  networking.hostName = config.myNixosSettings.hostName;

  myNixosSettings = {
    hostName = "nas";
    username = "nas";
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
