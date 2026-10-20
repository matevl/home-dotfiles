{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mySettings.nvidia.enable {
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
  };
}
