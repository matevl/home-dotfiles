{ config, lib, ... }:
let
  cfg = config.myNixosSettings.docker;
in
{
  options.myNixosSettings.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Docker container runtime and optional Nvidia CDI support";
    };
  };

  config = lib.mkIf cfg.enable {
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
        log-opts = {
          max-size = "20m";
          max-file = "3";
        };
      };
    };

    users.users.${config.myNixosSettings.username}.extraGroups = [ "docker" ];
    hardware.nvidia-container-toolkit.enable = config.myNixosSettings.nvidia.enable;
  };
}
