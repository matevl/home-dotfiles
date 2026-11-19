{ config, pkgs, ... }:

{
  # Enable Zsh at system level
  programs.zsh.enable = true;

  # User account
  users.users.${config.myNixosSettings.username} = {
    isNormalUser = true;
    description = config.myNixosSettings.username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };
}
