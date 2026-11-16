{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Shell tools ---
    mutagen
    ngrok
    # Git tools
    pre-commit

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
  ];
}
