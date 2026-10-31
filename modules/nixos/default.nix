{ ... }:

{
  imports = [
    ./options.nix
    ./system.nix
    ./desktop.nix
    ./users.nix
    ./docker.nix
    ./game.nix
    ./nvidia.nix
    ../../hardware-configuration.nix
  ];
}
