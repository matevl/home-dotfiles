{ pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [
    80 # Caddy HTTP reverse proxy
    443 # Caddy HTTPS reverse proxy
  ];

  services = {
    # Reverse Proxy
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
