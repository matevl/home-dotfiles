{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
  ];

  # Networking
  networking.networkmanager.enable = true;
  programs.ssh.package = pkgs.openssh_gssapi;

  # Time zone and Locale
  time.timeZone = config.mySettings.timeZone;
  i18n.defaultLocale = config.mySettings.defaultLocale;
  console.keyMap = config.mySettings.keyboardLayout;

  services.xserver.xkb = {
    layout = config.mySettings.keyboardLayout;
    variant = "";
  };

  # -- RAM / OOM Optimizations --
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5;
    freeMemKillThreshold = 1;
  };

  zramSwap = {
    enable = true;
    priority = 1000;
    algorithm = "zstd";
  };

  # Services
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    tree
    wget
    curl
    networkmanagerapplet
    steam-run
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  system.stateVersion = config.mySettings.stateVersion;
}
