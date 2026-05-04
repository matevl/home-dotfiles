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

  # DMS
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = false;
    settings = {
      wallpaper = osConfig.mySettings.wallpaper;
      background.type = "image";
      background.mode = "fill";
      session.lock.enable = false;
    };
  };

  # Kitty Terminal
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.8";
    };
  };

  # VS Code
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode.override {
      commandLineArgs = "--disable-features=WaylandPerSurfaceScale";
    };
    profiles.default.userSettings = {
      "window.titleBarStyle" = "native";
      "editor.fontSize" = 14;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "telemetry.telemetryLevel" = "off";
    };
  };
}
