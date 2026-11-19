{ ... }:

{
  imports = [
    ./options.nix
    ./desktop-environment.nix
    ./docker.nix
    ./ldmtool.nix
    ./game.nix
    ./nvidia.nix
    ./core
  ];
}
