{ lib, ... }:
let
  ports = import ./ports.nix;
  inherit (import ./sites.nix) domain sites;
in
{
  networking = {
    resolvconf.useLocalResolver = false;
    firewall.interfaces."tailscale0".allowedTCPPorts = (lib.mapAttrsToList (_: s: s.listen) sites) ++ [
      ports.forgejoSsh
    ];
  };

  services = {
    tailscale.permitCertUid = "caddy";

    caddy = {
      enable = true;
      extraConfig = ''
        (tinyauth) {
          forward_auth localhost:${toString ports.tinyauth} {
            uri /api/auth/caddy
          }
        }
      '';
      virtualHosts = lib.mapAttrs' (
        _: s:
        lib.nameValuePair "${domain}:${toString s.listen}" {
          extraConfig = ''
            ${lib.optionalString s.auth "import tinyauth"}
            reverse_proxy localhost:${toString s.backend}
          '';
        }
      ) sites;
    };
  };
}
