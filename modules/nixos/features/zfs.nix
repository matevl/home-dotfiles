{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixosSettings.zfs;
in
{
  options.myNixosSettings.zfs = {
    enable = lib.mkEnableOption "ZFS storage support";

    pools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "tank" ];
      description = "ZFS pools to import automatically at boot.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.networking.hostId != null;
        message = "networking.hostId must be set when myNixosSettings.zfs is enabled.";
      }
    ];

    boot = {
      supportedFilesystems = [ "zfs" ];
      zfs = {
        extraPools = cfg.pools;
        forceImportRoot = false;
      };
    };

    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };
}
