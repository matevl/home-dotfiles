{ config, lib, ... }:
let
  cfg = config.myNixosSettings.tailscale;
in
{
  options.myNixosSettings.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN mesh network";
    routingFeatures = lib.mkOption {
      type = lib.types.enum [
        "none"
        "client"
        "server"
        "both"
      ];
      default = "client";
      description = "Tailscale routing features mode";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = cfg.routingFeatures;
    };

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };
}
