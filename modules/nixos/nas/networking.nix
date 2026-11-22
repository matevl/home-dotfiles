{ ... }: {
  networking.firewall.allowedTCPPorts = [
    80 # Caddy HTTP reverse proxy
    443 # Caddy HTTPS reverse proxy
  ];
}
