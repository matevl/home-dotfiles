{
  config,
  lib,
  ...
}:
{
  services = {
    filebrowser = {
      enable = lib.mkDefault true;
      openFirewall = lib.mkDefault true;
      settings = {
        address = "0.0.0.0";
        port = 8085;
        root = "/srv/storage";
      };
    };

    cockpit = {
      enable = lib.mkDefault true;
      openFirewall = lib.mkDefault true;
      port = 9090;
      settings = {
        WebService = {
          AllowUnencrypted = true;
        };
      };
    };

    # Dashboard
    homepage-dashboard = {
      enable = true;
      openFirewall = true;
      listenPort = 8082;
      settings = {
        title = "NAS Hub";
        theme = "dark";
      };
      services = [
        {
          "Media & Files" = [
            {
              Jellyfin = {
                icon = "jellyfin.png";
                href = "http://jellyfin.nas";
                description = "Movies & TV Shows";
              };
            }
            {
              FileBrowser = {
                icon = "filebrowser.png";
                href = "http://files.nas";
                description = "Shared files & uploads";
              };
            }
          ];
        }
        {
          "Personal & Admin" = [
            {
              Trilium = {
                icon = "trilium.png";
                href = "http://trilium.nas";
                description = "Knowledge base & notes";
              };
            }
            {
              Cockpit = {
                icon = "cockpit.png";
                href = "https://nas:9090";
                description = "System & ZFS administration";
              };
            }
          ];
        }
      ];
    };

    #Reverse Proxy
    caddy = {
      enable = true;
      virtualHosts = {
        "http://nas" = {
          extraConfig = "reverse_proxy localhost:8082";
        };
        "http://jellyfin.nas" = {
          extraConfig = "reverse_proxy localhost:8096";
        };
        "http://files.nas" = {
          extraConfig = "reverse_proxy localhost:8085";
        };
        "http://trilium.nas" = {
          extraConfig = "reverse_proxy localhost:8080";
        };
      };
    };

    trilium-server = {
      enable = lib.mkDefault true;
      host = "0.0.0.0";
      port = 8080;
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

  systemd.tmpfiles.rules = [
    "d /srv/storage 0775 root users -"
    "d /srv/dockge/data 0755 root root -"
    "d /srv/stacks 0755 root root -"
  ];
}
