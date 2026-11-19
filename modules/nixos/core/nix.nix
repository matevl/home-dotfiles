{ pkgs, ... }: {
  # Nix configuration
  nix = {
    # GC options
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Nix settings
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      download-buffer-size = 536870912;
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;
    };
  };

  # Programs
  programs = {
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
    ];
  };
}
