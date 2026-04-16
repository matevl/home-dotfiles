{ config, pkgs, ... }:
let 
  wallpaper = "/home/mat/home/images/mainwallpaper.png";
in
{
  home.username = "mat";
  home.homeDirectory = "/home/mat";

  # User Apps
  home.packages = with pkgs; [
    # Apps
    brave
    discord
    deezer-desktop
    nautilus

    # General tools
    gtop

    # Compiler
    gcc
    cargo
    uv
    python3

    # Code tools
    neovim
    jetbrains.rust-rover
    godot_4
    vscode
    github-desktop

    docker

    rustfmt

    # Sway tools
    waybar
    mako
    swaylock
    nerd-fonts.jetbrains-mono
    wofi
    swaybg
  ];

  # Zsh & Oh My Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell";
    };

    shellAliases = {
      clean-nixos = "sudo nix-collect-garbage -d";
    };
  };

  # Kitty Terminal
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.9";
    };
  };

  # VS Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {
      "editor.fontSize" = 14;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "telemetry.enableTelemetry" = false;
    };
  };

  # Sway
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      bars = [ { command = "waybar"; } ];
      startup = [
        { command = "swaybg -i ${wallpaper} -m fill"; always = true; }
      ];
      defaultWorkspace = "workspace number 1";
      keybindings = import ./sway/keybindings.nix { inherit config pkgs; };
      input = { "type:keyboard" = { xkb_layout = "fr"; }; };
      gaps = {
        inner = 5;
        outer = 3;
      };
      window = {
        border = 2;
        titlebar = false;
      };
    };
  };

  # Theme consistency (GNOME files/Nautilus will look good)
  gtk = {
    enable = true;
    theme = { name = "adw-gtk3-dark"; package = pkgs.adw-gtk3; };
  };

  # Force dark mode for GNOME/GTK apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///${wallpaper}";
      picture-uri-dark = "file:///${wallpaper}";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
