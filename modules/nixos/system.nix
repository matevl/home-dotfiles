{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Nixpkgs configuration
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-38.8.4"
    ];
  };

  # Nix configuration
  nix = {
    # GC options
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Nix settings
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      download-buffer-size = 536870912;
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;
    };
  };

  # Networking
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Experimental = true;
        FastConnectable = false;
      };
    };
  };

  # Time zone and Locale
  time.timeZone = config.mySettings.timeZone;
  i18n.defaultLocale = config.mySettings.defaultLocale;
  console.keyMap = config.mySettings.keyboardLayout;

  # Swap
  zramSwap = {
    enable = true;
    priority = 1000;
    algorithm = "zstd";
  };

  # Services
  services = {
    gnome.gnome-keyring.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };

    # -- RAM / OOM Optimizations --
    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 5;
      freeMemKillThreshold = 1;
    };
  };

  # Security
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    gcc
    man-pages
    man-pages-posix
    tree
    wget
    curl
    networkmanagerapplet
    bluez
    steam-run
  ];

  # Programs
  programs = {
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
    ];

    ssh.package = pkgs.openssh_gssapi;
  };

  system.stateVersion = config.mySettings.stateVersion;
}
