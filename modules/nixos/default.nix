{ ... }:

{
  imports = [
    ./options.nix
    ./system.nix
    ./desktop-environment.nix
    ./users.nix
    ./docker.nix
    ./game.nix
    ./nvidia.nix
  ];
}
