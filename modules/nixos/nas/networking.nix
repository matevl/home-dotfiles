{ config, lib, ... }: {
  networking.firewall.allowedTCPPorts = [
    80
    443
  ]
  ++ lib.optionals config.myNixosSettings.docker.enable [ 5001 ];
}
