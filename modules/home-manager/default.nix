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

  home = {
    # --- User info ---
    username = osConfig.mySettings.username;
    homeDirectory = "/home/${osConfig.mySettings.username}";
    stateVersion = osConfig.mySettings.stateVersion;
  };

  programs.home-manager.enable = true;
}
