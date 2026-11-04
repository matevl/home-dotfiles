{ config, ... }:

{
  virtualisation.docker = {
    enable = true;

    enableOnBoot = false;

    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };

    daemon.settings = {
      features.cdi = config.mySettings.nvidia.enable;
      log-driver = "local";
    };
  };

  hardware.nvidia-container-toolkit.enable = config.mySettings.nvidia.enable;
}
