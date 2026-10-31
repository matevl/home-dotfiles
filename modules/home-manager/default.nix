{ osConfig, ... }:

{
  imports = [
    ./packages.nix
    ./apps.nix
    ./vscode.nix
    ./services.nix
    ./gnome
    ./helix
    ./hypr/hypridle.nix
    ./niri
    ./zsh
  ];

  home.stateVersion = osConfig.mySettings.stateVersion;
}
