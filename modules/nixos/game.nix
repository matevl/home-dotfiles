{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.mySettings.game.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      steam-hardware.enable = true;
    };

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
