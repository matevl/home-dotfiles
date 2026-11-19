{
  config,
  lib,
  ...
}:
{
  services.filebrowser = {
    enable = lib.mkDefault true;
    openFirewall = lib.mkDefault true;
    settings = {
      address = "0.0.0.0";
      port = 8080;
      root = "/srv/storage";
    };
  };

  services.cockpit = {
    enable = lib.mkDefault true;
    openFirewall = lib.mkDefault true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.dockge = lib.mkIf config.myNixosSettings.docker.enable {
      image = "louislam/dockge:1";
      ports = [ "5001:5001" ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/srv/dockge/data:/app/data"
        "/srv/stacks:/srv/stacks"
      ];
      environment = {
        DOCKGE_STACKS_DIR = "/srv/stacks";
      };
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkIf config.myNixosSettings.docker.enable [ 5001 ];

  systemd.tmpfiles.rules = [
    "d /srv/storage 0775 root users -"
    "d /srv/dockge/data 0755 root root -"
    "d /srv/stacks 0755 root root -"
  ];
}
