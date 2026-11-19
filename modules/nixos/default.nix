{ ... }:

{
  imports = [
    ./options.nix
    ./system.nix
    ./desktop-environment.nix
    ./docker.nix
    ./game.nix
    ./nvidia.nix
    ./core
  ];
}
