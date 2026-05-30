{ inputs, ... }:

{
  imports = [
    ./options.nix
    ./system.nix
    ./desktop.nix
    ./users.nix
    ./docker.nix
  ];
}
