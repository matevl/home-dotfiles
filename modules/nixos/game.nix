{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.mySettings.game.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
