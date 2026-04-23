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

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = vars.lockWallpaper;
          blur_passes = 0;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(15, 15, 15)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
