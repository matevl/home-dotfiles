{ pkgs, pkgs-unstable, ... }:

let
  wrapElectron = pkg: pkgs.symlinkJoin {
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
    (wrapElectron pkgs-unstable.vesktop)
    (wrapElectron pkgs-unstable.deezer-desktop)
    nautilus
    vlc
    resources
    pkgs-unstable.moonlight-qt

    # --- General tools ---
    btop
    zerotierone

    # --- Shell tools ---
    fastfetch
    eza
    bat
    screen
    mutagen
    docker

    # --- Code tools ---
    # C/C++
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
    nh

    # IDEs/editors
    (wrapJetBrains pkgs-unstable.jetbrains.rust-rover)
    pkgs-unstable.antigravity

    # Game engines
    pkgs-unstable.godot_4
    pkgs-unstable.gdtoolkit_4

    # Git tools
    (wrapElectron pkgs-unstable.github-desktop)
    lazygit

    # --- Windows managers tools ---
    nerd-fonts.jetbrains-mono
    wl-clipboard
    gnome-screenshot
  ];
}
