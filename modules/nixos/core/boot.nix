{ ... }: {
  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "vm.swappiness" = 60;
    };

    supportedFilesystems = [ "ntfs" ];

    kernelModules = [ "dm_mod" ];
  };

  # Swap
  zramSwap = {
    enable = true;
    priority = 1000;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  systemd = {
    # -- RAM / OOM Optimizations --
    oomd = {
      enable = true;
      enableUserSlices = true;
    };
  };
}
