{ config, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # Limit hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
        after_sleep_cmd = "hyprctl msg dispatch dpms on"; # Don't require 2 keypresses to wake.
      };

      listener = [
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600; # 10min
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
        {
          timeout = 900; # 15min
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
