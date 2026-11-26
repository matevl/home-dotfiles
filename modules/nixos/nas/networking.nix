{ ... }:
let
  ports = import ./ports.nix;
in
{
  networking = {
    resolvconf.useLocalResolver = false;
    firewall = {
      allowedTCPPorts = [
        ports.caddyHttp
        ports.caddyHttps
      ];
      interfaces."tailscale0" = {
        allowedUDPPorts = [ ports.dns ];
        allowedTCPPorts = [ ports.dns ];
      };
    };
  };

  services = {
    # Reverse Proxy
    caddy = {
      enable = true;
      extraConfig = ''
        (tinyauth) {
          forward_auth localhost:${toString ports.tinyauth} {
            uri /api/auth/caddy
          }
        }
      '';
      virtualHosts = {
        "http://auth.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.tinyauth}";
        };

        "http://nas" = {
          extraConfig = "redir http://hub.home.nas{uri} permanent";
        };

        "http://files.home.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.filebrowser}
          '';
        };

        "http://dockge.home.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.dockge}
          '';
        };

        "http://hub.home.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.homepage}
          '';
        };

        "http://torrent.home.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.transmission}
          '';
        };

        "http://cockpit.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.cockpit}";
        };

        "http://git.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.forgejo}";
        };

        "http://latex.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.aldine}";
        };

        "http://photos.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.immich}";
        };

        "http://jellyfin.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.jellyfin}";
        };

        "http://trilium.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.trilium}";
        };

        "http://status.home.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.uptimeKuma}";
        };
      };
    };

    # DNS
    dnsmasq = {
      enable = true;
      settings = {
        interface = "tailscale0";
        bind-dynamic = true;
        no-resolv = true;
        address = "/.home.nas/100.122.18.36";
      };
    };
  };
}
