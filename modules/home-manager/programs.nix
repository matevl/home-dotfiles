{ config, pkgs, ... }:
{
  programs = {
    # --- General tools ---
    btop.enable = true;
    lazygit.enable = true;

    # --- Shell tools ---
    fastfetch.enable = true;
    bat.enable = true;
    eza.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Python
    uv.enable = true;
    ruff.enable = true;

    # NIX
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/home-dotfiles";
    };

    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };

    # --- Apps ---
    chromium = {
      enable = true;
      package = pkgs.brave;
    };

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
      package = pkgs.unstable.vesktop;
      vencord.useSystem = true;
    };
  };
}
