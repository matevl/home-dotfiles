{ config, ... }:
let
  ports = import ./ports.nix;
  fqdn = "${config.networking.hostName}.${config.myNixosSettings.tailscale.tailnetDomain}";
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
        "https://${fqdn}" = {
          extraConfig = ''
            handle /login* {
              reverse_proxy localhost:${toString ports.tinyauth}
            }
            handle /logout* {
              reverse_proxy localhost:${toString ports.tinyauth}
            }
            handle /api/auth/* {
              reverse_proxy localhost:${toString ports.tinyauth}
            }
            handle /assets/* {
              reverse_proxy localhost:${toString ports.tinyauth}
            }

            handle {
              forward_auth localhost:${toString ports.tinyauth} {
                uri /api/auth/caddy
                header_up X-Forwarded-Proto https
              }
              reverse_proxy localhost:${toString ports.homepage}
            }
          '';
        };

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
          extraConfig = ''
            reverse_proxy localhost:${toString ports.cockpit} {
              header_up X-Forwarded-Proto {scheme}
            }
          '';
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

    tailscale = {
      serve = {
        enable = true;
        services = {
          "${config.networking.hostName}" = {
            advertised = true;
            endpoints = {
              "tcp:${toString ports.caddyHttps}" = "http://127.0.0.1:${toString ports.caddyHttps}";
            };
          };
        };
      };
      permitCertUid = "caddy";
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
