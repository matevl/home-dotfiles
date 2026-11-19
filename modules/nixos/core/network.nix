{ pkgs, ... }: {
  # Networking
  networking.networkmanager.enable = true;

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
