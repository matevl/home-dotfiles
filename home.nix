{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  vars = import ./variables.nix;
in
{
  imports = [
    ./sway
    ./gnome
    ./helix
  ];

  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;

  # User Apps
  home.packages = with pkgs; [
    # --- Apps ---
    brave
    discord
    deezer-desktop
    nautilus
    vlc

    # General tools
    gtop
    fastfetch

    # --- Code tools ---
    # Compiler
    # C
    gcc
    gnumake
    cmake

    # Rust
    rustc
    cargo
    rustfmt

    # Python
    python3
    uv
    ruff

    # JS/TS
    nodejs

    # NIX
    nix
    nixfmt

    # IDEs/editors
    jetbrains.rust-rover
    pkgs-unstable.godot_4
    vscode

    # Git tools
    github-desktop
    gitkraken

    # Containers
    docker

    # --- Sway tools ---
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
      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    initContent = ''
      setopt HIST_IGNORE_SPACE
      fastfetch
    '';

    shellAliases = {
      clean-nixos = "sudo nix-collect-garbage -d";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # Kitty Terminal
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.8";
    };
  };

  # VS Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.userSettings = {
      "editor.fontSize" = 14;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "telemetry.enableTelemetry" = false;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
