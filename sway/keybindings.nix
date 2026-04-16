{ config, pkgs, ... }:
let
  modifier = config.wayland.windowManager.sway.config.modifier;
in
pkgs.lib.mkOptionDefault {
  "${modifier}+ampersand" = "workspace number 1";
  "${modifier}+eacute" = "workspace number 2";
  "${modifier}+quotedbl" = "workspace number 3";
  "${modifier}+apostrophe" = "workspace number 4";
  "${modifier}+parenleft" = "workspace number 5";
  "${modifier}+minus" = "workspace number 6";
  "${modifier}+egrave" = "workspace number 7";
  "${modifier}+underscore" = "workspace number 8";
  "${modifier}+ccedilla" = "workspace number 9";
  "${modifier}+agrave" = "workspace number 10";

  "${modifier}+1" = null;
  "${modifier}+2" = null;
  "${modifier}+3" = null;
  "${modifier}+4" = null;
  "${modifier}+5" = null;
  "${modifier}+6" = null;
  "${modifier}+7" = null;
  "${modifier}+8" = null;
  "${modifier}+9" = null;
  "${modifier}+0" = null;

  "${modifier}+Shift+ampersand" = "move container to workspace number 1";
  "${modifier}+Shift+eacute" = "move container to workspace number 2";
  "${modifier}+Shift+quotedbl" = "move container to workspace number 3";
  "${modifier}+Shift+apostrophe" = "move container to workspace number 4";
  "${modifier}+Shift+parenleft" = "move container to workspace number 5";
  "${modifier}+Shift+minus" = "move container to workspace number 6";
  "${modifier}+Shift+egrave" = "move container to workspace number 7";
  "${modifier}+Shift+underscore" = "move container to workspace number 8";
  "${modifier}+Shift+ccedilla" = "move container to workspace number 9";
  "${modifier}+Shift+agrave" = "move container to workspace number 10";

  "${modifier}+Shift+1" = null;
  "${modifier}+Shift+2" = null;
  "${modifier}+Shift+3" = null;
  "${modifier}+Shift+4" = null;
  "${modifier}+Shift+5" = null;
  "${modifier}+Shift+6" = null;
  "${modifier}+Shift+7" = null;
  "${modifier}+Shift+8" = null;
  "${modifier}+Shift+9" = null;
  "${modifier}+Shift+0" = null;

  "${modifier}+Shift+l" = "exec swaylock -f -c 000000";
}
