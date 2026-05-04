{ config, pkgs, ... }:

{
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Enable Zsh at system level
  programs.zsh.enable = true;

  # User account
  users.users.${config.mySettings.username} = {
    isNormalUser = true;
    description = config.mySettings.username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "docker"
    ];
  };
}
