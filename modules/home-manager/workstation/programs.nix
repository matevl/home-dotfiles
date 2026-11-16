{ pkgs, ... }:
{
  programs = {
    # --- Apps ---
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        background_opacity = "0.8";
      };
    };

    obsidian = {
      enable = true;
      package = pkgs.unstable.obsidian;
    };

    vesktop = {
      enable = true;
      package = pkgs.unstable.vesktop.override {
        withSystemVencord = true;
        vencord = pkgs.unstable.vencord;
      };
    };
  };
}
