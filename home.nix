{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  vars = import ./variables.nix;
in
{
  imports = [
    ./gnome
    ./helix
    ./hypr/hyprlock.nix
    ./niri
    inputs.dms.homeModules.default
  ];

  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;

  # User Apps
  home.packages = with pkgs; [
    # --- Apps ---
    brave
    vesktop
    deezer-desktop
    nautilus
    vlc

    # General tools
    btop
    fastfetch
    krb5

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

    # --- Windows managers tools ---
    swayidle
    nerd-fonts.jetbrains-mono
  ];

  services.ssh-agent.enable = true;

  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = false;

    settings = {
      wallpaper = vars.wallpaper;
      background.type = "image";
      background.mode = "fill";
    };
  };

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
      "window.titleBarStyle" = "native";
      "editor.fontSize" = 14;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "telemetry.telemetryLevel" = "off";
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;
  home.stateVersion = vars.stateVersion;
}
