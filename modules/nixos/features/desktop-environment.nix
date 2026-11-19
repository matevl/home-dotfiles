{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixosSettings.desktopEnvironment;
in
{
  options.myNixosSettings.desktopEnvironment.enable = lib.mkEnableOption "DE/WM";

  config = lib.mkIf cfg.enable {
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

    # Security
    security = {
      polkit.enable = true;
      pam.services.login.enableGnomeKeyring = true;
    };

    services = {
      gnome.gnome-keyring.enable = true;

      logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
      };

      flatpak.enable = true;

      xserver = {
        enable = true;
        xkb = {
          layout = config.myNixosSettings.keyboardLayout;
          variant = "";
        };
      };

      displayManager.gdm.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber = {
          enable = true;
          extraConfig = {
            "10-bluetooth-policy" = {
              "wireplumber.settings" = {
                "bluetooth.autoswitch-to-headset-profile" = false;
              };
            };
          };
        };
      };

      blueman.enable = true;
    };
  };
}
