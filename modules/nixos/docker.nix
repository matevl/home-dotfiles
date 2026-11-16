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
      features.cdi = config.myNixosSettings.nvidia.enable;
      log-driver = "local";
    };
  };

  users.users.${config.myNixosSettings.username}.extraGroups = [ "docker" ];
  hardware.nvidia-container-toolkit.enable = config.myNixosSettings.nvidia.enable;
}
