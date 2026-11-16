{ ... }:

{
  imports = [
    ./firefox.nix
    ./game.nix
    ./gnome.nix
    ./hypr.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./vscode.nix
    ./xdg.nix
    ../core
    ./niri
  ];
}
