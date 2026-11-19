{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Experimental = true;
        FastConnectable = false;
      };
    };
  };

  # Services
  services = {
    gnome.gnome-keyring.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };

    flatpak.enable = config.myNixosSettings.desktopEnvironment.enable;
  };

  # Security
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    ldmtool
  ];

  systemd = {
    services.ldmtool = {
      description = "Scan and map Windows LDM dynamic volumes";
      wantedBy = [ "sysinit.target" ];
      unitConfig.DefaultDependencies = false;
      wants = [ "systemd-udev-settle.service" ];
      after = [
        "systemd-udevd.service"
        "systemd-udev-trigger.service"
        "systemd-udev-settle.service"
        "systemd-modules-load.service"
      ];
      before = [
        "local-fs-pre.target"
        "shutdown.target"
      ];
      conflicts = [ "shutdown.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.ldmtool}/bin/ldmtool create all";
        RemainAfterExit = true;
      };
    };
  };
}
