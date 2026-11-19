{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixosSettings.jellyfin;
in
{
  options.myNixosSettings.jellyfin.enable = lib.mkEnableOption "Jellyfin media server";

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];

    users.users.jellyfin.extraGroups = lib.mkIf config.myNixosSettings.nvidia.enable [
      "video"
      "render"
    ];
  };
}
