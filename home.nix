{ config, pkgs, ... }:

{
  home.username = "mat";
  home.homeDirectory = "/home/mat";

  # User Apps
  home.packages = with pkgs; [
    # other
    brave

    discord
    deezer-desktop
    nautilus

    # Code
    gcc

    neovim
    jetbrains.rust-rover
    godot_4
    vscode
    github-desktop

    docker    

    # Sway tools
    waybar
    mako
    swaylock
    nerd-fonts.jetbrains-mono
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
      theme = "robbyrussell"; # Simple and effective
    };

    shellAliases = {
      update-nixos = "sudo nixos-rebuild switch --flake .#nixos";
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
      input = { "type:keyboard" = { xkb_layout = "fr"; }; };
    };
  };

  # Theme consistency (GNOME files/Nautilus will look good)
  gtk = {
    enable = true;
    theme = { name = "adw-gtk3-dark"; package = pkgs.adw-gtk3; };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
