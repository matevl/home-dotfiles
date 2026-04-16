{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone and Locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console.keyMap = "fr";
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Desktop Environments
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Services
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;

  # Enable Zsh at system level
  programs.zsh.enable = true;

  # User account
  users.users.mat = {
    isNormalUser = true;
    description = "mat";
    shell = pkgs.zsh; # Zsh as default
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  environment.systemPackages = with pkgs; [
    git
    tree
    vim
    wget
    curl
    networkmanagerapplet
  ];

  system.stateVersion = "25.11";
}
