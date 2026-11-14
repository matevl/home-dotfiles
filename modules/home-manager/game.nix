{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.mySettings.game.enable {
    programs = {
      prismlauncher = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      unstable.heroic
    ];
  };
}
