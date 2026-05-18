{ osConfig, inputs, ... }:

{
  imports = [
    ./packages.nix
    ./apps.nix
    ./vscode.nix
    ./shell.nix
    ./services.nix
    ./gnome
    ./helix
    ./hypr/hyprlock.nix
    ./hypr/hypridle.nix
    ./niri
    ./zsh
  ];

  home.username = osConfig.mySettings.username;
  home.homeDirectory = "/home/${osConfig.mySettings.username}";
  home.stateVersion = osConfig.mySettings.stateVersion;
  programs.home-manager.enable = true;
}
