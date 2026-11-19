{ lib, ... }:

{
  imports = [
    ./desktop-environment.nix
    ../core
    ../features
  ];

  myNixosSettings.desktopEnvironment.enable = lib.mkDefault true;
}
