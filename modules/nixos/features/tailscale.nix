{ config, lib, ... }:
let
  cfg = config.myNixosSettings.tailscale;
in
{
  options.myNixosSettings.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN mesh network";
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };
}
