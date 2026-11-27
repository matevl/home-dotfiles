let
  ports = import ./ports.nix;
  domain = "nas.tail1b1266.ts.net";
  sites = {
    hub = {
      listen = ports.caddyHttps;
      backend = ports.homepage;
      auth = true;
    };
    auth = {
      listen = 8440;
      backend = ports.tinyauth;
      auth = false;
    };
    files = {
      listen = 8441;
      backend = ports.filebrowser;
      auth = true;
    };
    dockge = {
      listen = 8442;
      backend = ports.dockge;
      auth = true;
    };
    torrent = {
      listen = 8443;
      backend = ports.transmission;
      auth = true;
    };
    cockpit = {
      listen = 8444;
      backend = ports.cockpit;
      auth = false;
    };
    git = {
      listen = 8445;
      backend = ports.forgejo;
      auth = false;
    };
    latex = {
      listen = 8446;
      backend = ports.aldine;
      auth = false;
    };
    photos = {
      listen = 8447;
      backend = ports.immich;
      auth = false;
    };
    jellyfin = {
      listen = 8448;
      backend = ports.jellyfin;
      auth = false;
    };
    trilium = {
      listen = 8449;
      backend = ports.trilium;
      auth = false;
    };
    status = {
      listen = 8450;
      backend = ports.uptimeKuma;
      auth = false;
    };
  };
  portSuffix = s: if s.listen == ports.caddyHttps then "" else ":${toString s.listen}";
in
{
  inherit domain sites;
  url = name: "https://${domain}${portSuffix sites.${name}}";
}
