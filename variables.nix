let
  username = "mat";
  homeDirectory = "/home/${username}";
in
{
  inherit username homeDirectory;
  wallpaper = "${homeDirectory}/home/wallpapers/mainwallpaper.png";

  hostName = "nixos";
  timeZone = "Europe/Paris";
  defaultLocale = "en_US.UTF-8";
  keyboardLayout = "fr";
  stateVersion = "25.11";
}
