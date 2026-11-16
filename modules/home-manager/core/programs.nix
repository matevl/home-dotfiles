{ config, ... }:
{
  programs = {
    # --- Shell tools ---
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    lazygit.enable = true;
    screen.enable = true;

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
  };
}
