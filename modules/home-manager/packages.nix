{ pkgs, pkgs-unstable, ... }:

let
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
in
{
  home.packages = with pkgs; [
    # --- Apps ---
    (wrapElectron vesktop)
    (wrapElectron deezer-desktop)
    nautilus
    vlc

    # --- General tools ---
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
    nixfmt-tree

    # IDEs/editors
    (wrapJetBrains pkgs-unstable.jetbrains.rust-rover)
    pkgs-unstable.antigravity

    # Game engines
    pkgs-unstable.godot_4
    pkgs-unstable.gdtoolkit_4

    # Git tools
    (wrapElectron github-desktop)
    lazygit

    # --- Windows managers tools ---
    nerd-fonts.jetbrains-mono
    wl-clipboard
  ];
}
