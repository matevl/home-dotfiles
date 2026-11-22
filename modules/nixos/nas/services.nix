{
  pkgs,
  lib,
  ...
}:
{
  services = {
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

        "http://photos.nas" = {
          extraConfig = "reverse_proxy localhost:2283";
        };

        "http://jellyfin.nas" = {
          extraConfig = "reverse_proxy localhost:8096";
        };

        "http://trilium.nas" = {
          extraConfig = "reverse_proxy localhost:8080";
        };
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

    filebrowser = {
      enable = lib.mkDefault true;
      openFirewall = false;
      settings = {
        address = "0.0.0.0";
        port = 8085;
        root = "/srv/storage";
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
            {
              Immich = {
                icon = "immich.png";
                href = "http://photos.nas";
                description = "Photos & videos backup";
              };
            }
            {
              Trilium = {
                icon = "trilium.png";
                href = "http://trilium.nas";
                description = "Knowledge base & notes";
              };
            }
          ];
        }
        {
          "Personal & Admin" = [
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

    immich = {
      enable = true;
      host = "127.0.0.1";
      port = 2283;
      openFirewall = false;
      mediaLocation = "/srv/storage/immich";
      accelerationDevices = null;
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

  environment.systemPackages = [
    pkgs.cockpit-zfs
    (pkgs.writeScriptBin "tinyauth-setup" ''
      #!/bin/sh
      # Usage: sudo tinyauth-setup
      # Follow the 3 interactive prompts: Username, Password, then 'y' for Docker format.
      set -eu

      if [ "$(id -u)" -ne 0 ]; then
        echo "Run as root: sudo tinyauth-setup" >&2
        exit 1
      fi

      ENV_FILE="/etc/tinyauth.env"

      USER_LINE=$(${pkgs.docker}/bin/docker run --rm -it ghcr.io/steveiliop56/tinyauth:v3 user create --interactive | grep -E '^USERS=' | tr -d '\r')

      if [ -z "$USER_LINE" ]; then
        echo "Failed to generate user credentials." >&2
        exit 1
      fi

      # Replace $$ with $ for systemd EnvironmentFile
      USER_LINE_CLEAN=$(printf '%s' "$USER_LINE" | sed 's/\$\$/$/g')
      SECRET_KEY=$(${pkgs.openssl}/bin/openssl rand -hex 16)

      install -m 0600 -o root -g root /dev/null "$ENV_FILE"
      printf 'SECRET=%s\n%s\n' "$SECRET_KEY" "$USER_LINE_CLEAN" > "$ENV_FILE"

      systemctl restart docker-tinyauth.service
      echo "Updated $ENV_FILE and restarted docker-tinyauth.service."
    '')
  ];

  systemd.tmpfiles.rules = [
    "d /srv/storage 0775 root users -"
    "d /srv/dockge/data 0755 root root -"
    "d /srv/stacks 0755 root root -"
    "f /etc/tinyauth.env 0600 root root -"
    "d /srv/storage/immich 0750 immich immich -"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "immich-2.7.5"
  ];
}
