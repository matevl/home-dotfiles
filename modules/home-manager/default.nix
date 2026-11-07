{ osConfig, ... }:

{
  imports = [
    ./firefox.nix
    ./gnome.nix
    ./helix.nix
    ./hypr.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./vscode.nix
    ./xdg.nix
    ./zsh.nix
    ./niri
  ];

  home.stateVersion = osConfig.mySettings.stateVersion;
}
