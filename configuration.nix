{ config, pkgs, ... }:

let
  vars = import ./variables.nix;
in
{
  imports = [ ];

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

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone and Locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr";
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Desktop Environments
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable unnecessary default GNOME applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-console
    epiphany # Web browser
    geary # Mail client
    gnome-music
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-weather
    totem # Video player
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
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

  # Enable Zsh at system level
  programs.zsh.enable = true;

  # User account
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    shell = pkgs.zsh; # Zsh as default
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    tree
    vim
    wget
    curl
    networkmanagerapplet
    steam-run
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  system.stateVersion = "25.11";
}
