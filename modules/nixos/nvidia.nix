{
  config,
  lib,
  ...
}:
let
  cfg = config.mySettings.nvidia;
in
{
  options.mySettings.nvidia.enable = lib.mkEnableOption "Nvidia proprietary drivers and hardware acceleration";

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = true;

      open = true;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    boot.kernelParams = [
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    ];

    nix.settings = {
      substituters = [ "https://cache.nixos-cuda.org" ];
      trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
    };

    nixpkgs.config.cudaSupport = true;
  };
}
