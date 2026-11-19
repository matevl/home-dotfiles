{ config, pkgs, ... }:

{
  systemd.user.services.mutagen = {
    Unit = {
      Description = "Mutagen Sync Daemon";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mutagen}/bin/mutagen daemon run";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  services.network-manager-applet.enable = config.myHomeSettings.desktopEnvironmentConfig.enable;
}
