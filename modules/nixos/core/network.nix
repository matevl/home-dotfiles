{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Networking
  networking = {
    networkmanager.enable = true;
    hostName = lib.mkDefault config.myNixosSettings.hostName;
    hostId = lib.mkDefault (
      builtins.substring 0 8 (builtins.hashString "sha256" config.networking.hostName)
    );
  };

  programs.ssh.package = pkgs.openssh_gssapi;

  # Services
  services = {
    zerotierone.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
    };
  };
}
