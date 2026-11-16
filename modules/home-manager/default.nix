{ config, ... }:

{
  imports = [
    ./firefox.nix
    ./game.nix
    ./gnome.nix
    ./helix.nix
    ./hypr.nix
    ./options.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./vscode.nix
    ./xdg.nix
    ./zsh.nix
    ./niri
  ];

  home.stateVersion = config.myHomeSettings.stateVersion;
}
