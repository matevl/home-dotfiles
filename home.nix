{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  vars = import ./variables.nix;
  wrapElectron =
    pkg:
    pkgs.symlinkJoin {
      name = "${pkg.pname or pkg.name}-wrapped";
      paths = [ pkg ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${pkg.pname or pkg.name} \
          --append-flags "--disable-features=WaylandPerSurfaceScale"
      '';
    };
in
{
  imports = [
    ./gnome
    ./helix
    ./hypr/hyprlock.nix
    ./hypr/hypridle.nix
    ./niri
    ./zsh
    inputs.dms.homeModules.default
  ];

  # User
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;

  # User Apps
  home.packages = with pkgs; [
    # --- Apps ---
    (wrapElectron vesktop)
    (wrapElectron deezer-desktop)
    nautilus
    vlc

    # --- General tools ---
    # Monitor tools
    btop
    resources

    # --- Shell tools ---
    fastfetch
    eza
    bat
    screen
    mutagen
    docker

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
    clippy

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
    pkgs-unstable.antigravity

    # Game engines
    pkgs-unstable.godot_4
    pkgs-unstable.gdtoolkit_4

    # Git tools
    (wrapElectron github-desktop)

    # --- Windows managers tools ---
    nerd-fonts.jetbrains-mono
    wl-clipboard
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # DMS
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [ "--disable-features=WaylandPerSurfaceScale" ];
  };

  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = false;

    settings = {
      wallpaper = vars.wallpaper;
      background.type = "image";
      background.mode = "fill";
      session.lock.enable = false;
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
    package = pkgs-unstable.vscode.override {
      commandLineArgs = "--disable-features=WaylandPerSurfaceScale";
    };
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

  systemd.user.services.mutagen = {
    Unit = {
      Description = "Mutagen Sync Daemon";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mutagen}/bin/mutagen daemon run";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = vars.stateVersion;
}
