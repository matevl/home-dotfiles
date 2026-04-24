{
  config,
  pkgs,
  ...
}:
let
  vars = import ../variables.nix;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = vars.lockWallpaper;
          blur_passes = 0;
        }
      ];
      label = [
        # Hour-Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%I:%M %p")"'';
          color = "rgb(200, 200, 200)";
          font_size = 130;
          font_family = "JetBrainsMono Nerd Font ExtraBold";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
        # USER
        {
          monitor = "";
          text = "  $USER";
          color = "rgb(200, 200, 200)";
          font_size = 24;
          font_family = "JetBrainsMono Nerd Font ExtraBold";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
        # Battery
        {
          monitor = "";
          text = ''cmd[update:60000] echo "  $(cat /sys/class/power_supply/BAT*/capacity | head -1)%"'';
          color = "rgb(200, 200, 200)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font ExtraBold";
          position = "-45, 30";
          halign = "right";
          valign = "bottom";
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(15, 15, 15)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          placeholder_text = "<i>Type Password...</i>";
          hide_input = false;
          position = "0, 40";
          halign = "center";
          valign = "bottom";
          font_family = "JetBrainsMono Nerd Font ExtraBold";
        }
      ];
    };
  };
}
