{ ... }: {
  imports = [
    ./desktop-environment.nix
    ./docker.nix
    ./game.nix
    ./ldmtool.nix
    ./nvidia.nix
  ];
}
