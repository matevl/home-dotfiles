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
  networking.networkmanager.enable = true; # Use nmcli or GNOME settings for Wi-Fi

  # Time zone and Keyboard
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console.keyMap = "fr";
  # Configure X11 and Wayland keyboard layout
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # --- Desktop Environments ---

  # GNOME (for chill)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Sway (for work)
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # --- Services ---

  # Enable GNOME Keyring (needed for passwords)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Enable Polkit (required for Sway to handle permissions)
  security.polkit.enable = true;

  # Define user account
  users.users.mat = {
    isNormalUser = true;
    description = "mat";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Core system packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    networkmanagerapplet # Wi-Fi icon for Sway
  ];

  # NixOS state version
  system.stateVersion = "25.11";
}
