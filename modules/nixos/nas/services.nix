{
  lib,
  pkgs,
  ...
}:
let
  ports = import ./ports.nix;
in
{
  services = {
    cockpit = {
      enable = true;
      openFirewall = true;
      port = ports.cockpit;
      settings = {
        WebService = {
          AllowUnencrypted = true;
          ProtocolHeader = "X-Forwarded-Proto";
          Origins = lib.mkForce "http://cockpit.home.nas https://cockpit.home.nas ws://cockpit.home.nas wss://cockpit.home.nas https://192.168.1.72:${toString ports.cockpit} wss://192.168.1.72:${toString ports.cockpit} https://100.122.18.36:${toString ports.cockpit} wss://100.122.18.36:${toString ports.cockpit}";
        };
      };
    };

    filebrowser = {
      enable = true;
      openFirewall = false;
      settings = {
        address = "127.0.0.1";
        port = ports.filebrowser;
        root = "/srv/storage";
      };
    };

    forgejo = {
      enable = true;
      stateDir = "/srv/storage/forgejo";
      database.type = "sqlite3";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.home.nas";
          ROOT_URL = "http://git.home.nas/";
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = ports.forgejo;
          START_SSH_SERVER = true;
          SSH_PORT = ports.forgejoSsh;
          SSH_LISTEN_PORT = ports.forgejoSsh;
        };
        service = {
          DISABLE_REGISTRATION = true; # Only admin-created accounts
        };
      };
    };

    # Dashboard
    homepage-dashboard = {
      enable = true;
      openFirewall = false;
      listenPort = ports.homepage;
      allowedHosts = "hub.home.nas";
      settings = {
        title = "NAS Hub";
        theme = "dark";
      };
      services = [
        {
          "Media & Files" = [
            {
              "Aldine (LaTeX)" = {
                icon = "overleaf.png";
                href = "http://latex.home.nas";
                description = "Collaborative LaTeX editor";
              };
            }
            {
              FileBrowser = {
                icon = "filebrowser.png";
                href = "http://files.home.nas";
                description = "Shared files & uploads";
              };
            }
            {
              Immich = {
                icon = "immich.png";
                href = "http://photos.home.nas";
                description = "Photos & videos backup";
              };
            }
            {
              Jellyfin = {
                icon = "jellyfin.png";
                href = "http://jellyfin.home.nas";
                description = "Movies & TV Shows";
              };
            }
            {
              Transmission = {
                icon = "transmission.png";
                href = "http://torrent.home.nas";
                description = "Torrent client";
              };
            }
            {
              Trilium = {
                icon = "trilium.png";
                href = "http://trilium.home.nas";
                description = "Knowledge base & notes";
              };
            }
          ];
        }
        {
          "Dev & Admin" = [
            {
              Cockpit = {
                icon = "cockpit.png";
                href = "http://cockpit.home.nas";
                description = "System & ZFS administration";
              };
            }
            {
              Dockge = {
                icon = "dockge.png";
                href = "http://dockge.home.nas";
                description = "Docker Compose stacks manager";
              };
            }
            {
              Forgejo = {
                icon = "forgejo.png";
                href = "http://git.home.nas";
                description = "Self-hosted Git repositories";
              };
            }
            {
              "Uptime Kuma" = {
                icon = "uptime-kuma.png";
                href = "http://status.home.nas";
                description = "Service monitoring & alerts";
              };
            }
          ];
        }
      ];
    };

    immich = {
      enable = true;
      host = "127.0.0.1";
      port = ports.immich;
      openFirewall = false;
      mediaLocation = "/srv/storage/immich";
      accelerationDevices = null;
    };

    logind.settings.Login = {
      IdleAction = "ignore";
      HandleSuspendKey = "ignore";
      HandleHibernateKey = "ignore";
    };

    transmission = {
      enable = true;
      openFirewall = false;
      package = pkgs.transmission_4;
      webHome = pkgs.flood-for-transmission;
      settings = {
        rpc-port = ports.transmission;
        rpc-bind-address = "127.0.0.1";
        rpc-whitelist-enabled = false;
        rpc-host-whitelist-enabled = false;
        download-dir = "/srv/storage/downloads";
        incomplete-dir = "/srv/storage/downloads/.incomplete";
        incomplete-dir-enabled = true;
      };
    };

    tinyauth = {
      enable = true;
      environmentFile = "/etc/tinyauth.env";
      settings = {
        APPURL = "http://auth.home.nas";
        COOKIE_SECURE = "false";
        SERVER_ADDRESS = "127.0.0.1";
        SERVER_PORT = ports.tinyauth;
      };
    };

    trilium-server = {
      enable = true;
      host = "127.0.0.1";
      port = ports.trilium;
    };

    uptime-kuma = {
      enable = true;
      settings = {
        HOST = "127.0.0.1";
        PORT = toString ports.uptimeKuma;
      };
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      dockge = {
        image = "louislam/dockge:1";
        ports = [ "127.0.0.1:${toString ports.dockge}:5001" ];
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
  };

  environment.systemPackages = [
    #pkgs.cockpit-zfs
    pkgs.cockpit
    pkgs.tinyauth
    (pkgs.writeShellScriptBin "tinyauth-setup" ''
      set -euo pipefail

      if [ "$(id -u)" -ne 0 ]; then
        echo "Run as root: sudo tinyauth-setup" >&2
        exit 1
      fi

      trap 'stty echo 2>/dev/null || true' EXIT INT TERM

      printf "Username: "
      read -r USERNAME
      USERNAME=$(printf '%s' "$USERNAME" | ${pkgs.coreutils}/bin/tr -d '\r\n')

      if [ -z "$USERNAME" ]; then
        echo "Username cannot be empty." >&2
        exit 1
      fi

      printf "Password: "
      stty -echo
      read -r PASSWORD
      stty echo
      printf "\n"
      PASSWORD=$(printf '%s' "$PASSWORD" | ${pkgs.coreutils}/bin/tr -d '\r\n')

      if [ -z "$PASSWORD" ]; then
        echo "Password cannot be empty." >&2
        exit 1
      fi

      HASH_PAIR=$(printf '%s' "$PASSWORD" | ${pkgs.apacheHttpd}/bin/htpasswd -niB "$USERNAME" | ${pkgs.coreutils}/bin/tr -d '\r\n')
      ENV_FILE="/etc/tinyauth.env"

      ${pkgs.coreutils}/bin/install -m 0600 -o root -g root /dev/null "$ENV_FILE"
      printf 'TINYAUTH_AUTH_USERS=%s\n' "$HASH_PAIR" > "$ENV_FILE"

      ${pkgs.systemd}/bin/systemctl reset-failed tinyauth.service >/dev/null 2>&1 || true
      ${pkgs.systemd}/bin/systemctl restart tinyauth.service
      echo "Updated $ENV_FILE and restarted tinyauth.service."
    '')
  ];

  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };

    tmpfiles.rules = [
      "d /srv/storage 0775 root users -" # Shared ZFS pool mountpoint
      "d /srv/dockge/data 0755 root root -" # Dockge persistent data
      "d /srv/stacks 0755 root root -" # Docker Compose stacks
      "f /etc/tinyauth.env 0600 root root -" # Tinyauth secret and credentials
      "d /srv/storage/immich 0750 immich immich -" # Immich media library
      "d /srv/storage/downloads 0775 transmission users -" # Transmission download folder
      "d /srv/storage/downloads/.incomplete 0775 transmission users -" # Transmission incomplete folder
      "d /srv/storage/forgejo 0750 forgejo forgejo -" # Forgejo Git repositories and data
      "d /srv/storage/aldine 0755 root root -" # Aldine LaTeX root directory
      "d /srv/storage/aldine/data 0755 root root -" # Aldine projects and uploaded files
      "d /srv/storage/aldine/postgres 0700 999 999 -" # Aldine PostgreSQL database
    ];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "immich-2.7.5"
  ];
}
