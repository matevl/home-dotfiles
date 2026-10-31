{
  config,
  pkgs,
  ...
}:

let
  wrapElectron =
    pkg:
    pkgs.symlinkJoin {
      name = "${pkg.pname or pkg.name}-wrapped";
      paths = [ pkg ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        rm -f $out/bin/${pkg.meta.mainProgram or pkg.pname or pkg.name}
        makeWrapper ${pkg}/bin/${pkg.meta.mainProgram or pkg.pname or pkg.name} \
          $out/bin/${pkg.meta.mainProgram or pkg.pname or pkg.name} \
          --append-flags "--disable-features=WaylandPerSurfaceScale"
      '';
    };
  /*
    wrapJetBrains =
      pkg:
      pkgs.symlinkJoin {
        name = "${pkg.pname or pkg.name}-wrapped";
        paths = [ pkg ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/${pkg.pname or pkg.name} \
            --set _JAVA_AWT_WM_NONREPARENTING 1 \
            --add-flags "-Dwayland.enabled=true"
        '';
      };
  */
in
{
  programs = {
    # --- General tools ---
    btop.enable = true;
    lazygit.enable = true;

    # --- Shell tools ---
    fastfetch.enable = true;
    bat.enable = true;
    eza.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Python
    uv.enable = true;
    ruff.enable = true;

    # NIX
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/home-dotfiles";
    };
    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };

    # --- Apps ---
    vesktop = {
      enable = true;
      package = pkgs.unstable.vesktop;
      vencord.useSystem = true;
    };
  };

  home.packages = with pkgs; [
    # --- Apps ---
    (wrapElectron pkgs.unstable.deezer-desktop)
    nautilus
    vlc
    resources
    pkgs.unstable.moonlight-qt
    transmission_4-gtk

    # --- General tools ---
    ngrok

    # --- Shell tools ---
    screen
    mutagen

    # --- Code tools ---
    # C/C++
    gnumake
    cmake
    clang-tools

    # Rust
    rustc
    cargo
    rustfmt
    clippy

    # Python
    python3

    # JS/TS
    yarn

    # NIX
    nix
    nixfmt-tree
    nixd
    nix-tree
    deadnix

    # Game engines
    pkgs.unstable.godot_4
    pkgs.unstable.gdtoolkit_4

    # Git tools
    pre-commit
    github-desktop

    # --- Windows managers tools ---
    nerd-fonts.jetbrains-mono
    wl-clipboard
    gnome-screenshot
    xwayland-satellite

    # --- Multimedia controls ---
    brightnessctl
    pavucontrol

    # --- App utils ---
    desktop-file-utils
  ];
}
