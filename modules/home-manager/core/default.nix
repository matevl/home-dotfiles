{ config, ... }:
{
  imports = [
    ./helix.nix
    ../options.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./zsh.nix
  ];

  home.stateVersion = config.myHomeSettings.stateVersion;
}
