{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixosSettings.nvidia;
in
{
  options.myNixosSettings.nvidia = {
    enable = lib.mkEnableOption "Nvidia drivers and hardware acceleration";
    modern.enable = lib.mkEnableOption "open kernel modules and CUDA support for Turing (GTX 16xx / RTX 20xx) or newer GPUs";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = cfg.modern.enable;
      nvidiaSettings = config.myNixosSettings.desktopEnvironment.enable;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    boot.kernelParams = [
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    ];

    nix.settings = lib.mkIf cfg.modern.enable {
      substituters = [ "https://cache.nixos-cuda.org" ];
      trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
    };

    nixpkgs.config.cudaSupport = cfg.modern.enable;
  };
}
