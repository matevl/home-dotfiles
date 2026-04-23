{ config, pkgs, ... }:

let
  vars = import ../variables.nix;
  wallpaper = vars.wallpaper;
in
{
  # Sway
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      bars = [ ];
      startup = [
        {
          command = "swaybg -i ${wallpaper} -m fill";
          always = true;
        }
      ];
      defaultWorkspace = "workspace number 1";
      keybindings = import ./keybindings.nix { inherit config pkgs; };
      input = {
        "type:keyboard" = {
          xkb_layout = "fr";
        };
        "type:touchpad" = {
          click_method = "button_areas";
        };
      };
      gaps = {
        inner = 5;
        outer = 3;
      };
      window = {
        border = 2;
        titlebar = false;
      };
    };
  };
}
