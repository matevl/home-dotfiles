{
  config,
  lib,
  ...
}:
{
  services = {
    filebrowser = {
      enable = lib.mkDefault true;
      openFirewall = false;
      settings = {
        address = "0.0.0.0";
        port = 8085;
        root = "/srv/storage";
      };
    };

    cockpit = {
      enable = true;
      openFirewall = true;
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
      openFirewall = false;
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
            {
              Dockge = {
                icon = "dockge.png";
                href = "http://dockge.nas";
                description = "Docker Compose stacks manager";
              };
            }
          ];
        }
      ];
    };

    #Reverse Proxy
    caddy = {
      enable = true;
      extraConfig = ''
        (tinyauth) {
          forward_auth localhost:3000 {
            uri /api/auth/caddy
          }
        }
      '';
      virtualHosts = {
        "http://auth.nas" = {
          extraConfig = "reverse_proxy localhost:3000";
        };
        "http://nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:8082
          '';
        };

        "http://files.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:8085
          '';
        };

        "http://dockge.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:5001
          '';
        };

        "http://jellyfin.nas" = {
          extraConfig = "reverse_proxy localhost:8096";
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
    containers = {
      dockge = {
        image = "louislam/dockge:1";
        ports = [ "127.0.0.1:5001:5001" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/srv/dockge/data:/app/data"
          "/srv/stacks:/srv/stacks"
        ];
        environment = {
          DOCKGE_STACKS_DIR = "/srv/stacks";
        };
      };
      tinyauth = {
        image = "ghcr.io/steveiliop56/tinyauth:v3";
        ports = [ "127.0.0.1:3000:3000" ];
        environment = {
          APP_URL = "http://auth.nas";
          COOKIE_SECURE = "false";
        };
        environmentFiles = [ "/etc/tinyauth.env" ];
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/storage 0775 root users -"
    "d /srv/dockge/data 0755 root root -"
    "d /srv/stacks 0755 root root -"
    "f /etc/tinyauth.env 0600 root root -"
  ];
}
