{ config, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "dms ipc lock lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-on-monitors";
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
