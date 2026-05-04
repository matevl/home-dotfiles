{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
