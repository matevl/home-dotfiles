{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myNixosSettings.ldmtool;
in
{
  options.myNixosSettings.ldmtool.enable = lib.mkEnableOption "LDM tool that scans and maps Windows LDM dynamic volumes";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ldmtool
    ];

    systemd = {
      services.ldmtool = {
        description = "Scans and maps Windows LDM dynamic volumes";
        wantedBy = [ "sysinit.target" ];
        unitConfig.DefaultDependencies = false;
        wants = [ "systemd-udev-settle.service" ];
        after = [
          "systemd-udevd.service"
          "systemd-udev-trigger.service"
          "systemd-udev-settle.service"
          "systemd-modules-load.service"
        ];
        before = [
          "local-fs-pre.target"
          "shutdown.target"
        ];
        conflicts = [ "shutdown.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.ldmtool}/bin/ldmtool create all";
          RemainAfterExit = true;
        };
      };
    };
  };
}
