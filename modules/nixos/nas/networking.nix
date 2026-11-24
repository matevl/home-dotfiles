{ pkgs, ... }:
let
  ports = import ./ports.nix;
in
{
  networking.firewall.allowedTCPPorts = [
    ports.caddyHttp
    ports.caddyHttps
  ];

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
        "http://auth.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.tinyauth}";
        };
        "http://nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.homepage}
          '';
        };

        "http://files.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.filebrowser}
          '';
        };

        "http://dockge.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.dockge}
          '';
        };

        "http://torrent.nas" = {
          extraConfig = ''
            import tinyauth
            reverse_proxy localhost:${toString ports.transmission}
          '';
        };

        "http://git.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.forgejo}";
        };

        "http://latex.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.aldine}";
        };

        "http://photos.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.immich}";
        };

        "http://jellyfin.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.jellyfin}";
        };

        "http://trilium.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.trilium}";
        };

        "http://status.nas" = {
          extraConfig = "reverse_proxy localhost:${toString ports.uptimeKuma}";
        };
      };
    };

    # DNS
    dnsmasq = {
      enable = true;
      settings = {
        interface = "tailscale0";
        bind-interfaces = true;
        no-resolv = true;
        conf-dir = "/run/dnsmasq-tailscale";
      };
    };
  };

  systemd.services.dnsmasq = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    preStart = ''
      mkdir -p /run/dnsmasq-tailscale
      : > /run/dnsmasq-tailscale/nas.conf
      TAILSCALE_IP=$(${pkgs.tailscale}/bin/tailscale ip -4 || true)
      if [ -n "$TAILSCALE_IP" ]; then
        echo "address=/.nas/$TAILSCALE_IP" > /run/dnsmasq-tailscale/nas.conf
      fi
    '';
  };
}
