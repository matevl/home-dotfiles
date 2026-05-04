{ inputs, ... }:

{
  imports = [
    inputs.dms.nixosModules.default
    ./options.nix
    ./system.nix
    ./desktop.nix
    ./users.nix
    ./docker.nix
  ];
}
