{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.mySettings.game.enable {
    environment.systemPackages = with pkgs; [
      steam-run
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      xone.enable = true;
      steam-hardware.enable = true;
    };

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
