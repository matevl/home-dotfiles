{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixosSettings.desktopEnvironment;
in
{
  options.myNixosSettings.desktopEnvironment.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "DE/WM";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        pkgs.unstable.dux-shell
        pkgs.unstable.quickshell
      ];

      # Disable unnecessary default GNOME applications
      gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-console
        epiphany
        geary
        gnome-music
        gnome-calendar
        gnome-contacts
        gnome-maps
        gnome-weather
      ];

      sessionVariables.NIXOS_OZONE_WL = "1";
    };

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

    programs.niri.enable = true;

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

      flatpak.enable = config.myNixosSettings.desktopEnvironment.enable;

      xserver = {
        enable = true;
        xkb = {
          layout = config.myNixosSettings.keyboardLayout;
          variant = "";
        };
      };

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

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
