{
  pkgs,
  pkgs-unstable,
  osConfig,
  ...
}:

{
  # Chromium / Brave
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [ "--disable-features=WaylandPerSurfaceScale" ];
  };

  # DMS Config
  xdg.configFile."DankMaterialShell/settings.json".text = builtins.toJSON {
    wallpaper = osConfig.mySettings.wallpaper;
    background.type = "image";
    background.mode = "fill";
    session.lock.enable = false;
  };

  # Kitty Terminal
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.8";
    };
  };

  # Obsidian
  programs.obsidian = {
    enable = true;
    package = pkgs-unstable.obsidian;
  };
}
