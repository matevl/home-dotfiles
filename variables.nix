let
  username = "mat";
  homeDirectory = "/home/${username}";
in {
  inherit username homeDirectory;
  wallpaper = "${homeDirectory}/home/wallpapers/mainwallpaper.png";
}
