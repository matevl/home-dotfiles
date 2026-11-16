{ config, lib, ... }:

{
  config = lib.mkIf config.myHomeSettings.desktopEnvironmentConfig.enable {
    xdg.configFile = {
      "niri/config.kdl".source = ./config.kdl;
      "niri/config.kdl".force = true;
    };
  };
}
