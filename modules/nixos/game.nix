{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixosSettings.game;
in
{
  options.myNixosSettings.game.enable = lib.mkEnableOption "Steam, Proton and gaming optimizations";

  config = lib.mkIf cfg.enable {
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

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    users.users.${config.myNixosSettings.username}.extraGroups = [ "uinput" ];
  };
}
