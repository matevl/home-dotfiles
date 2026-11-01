{ osConfig, ... }:

{
  imports = [
    ./ai.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./vscode.nix
    ./xdg.nix
    ./gnome
    ./helix
    ./hypr
    ./niri
    ./zsh
  ];

  home.stateVersion = osConfig.mySettings.stateVersion;
}
