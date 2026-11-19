{ ... }: {
  imports = [
    ./desktop-environment.nix
    ./docker.nix
    ./game.nix
    ./jellyfin.nix
    ./ldmtool.nix
    ./nvidia.nix
  ];
}
