{
  pkgs,
  pkgs-unstable,
  osConfig,
  ...
}:

{
  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;
    dataFile."applications/mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

        "text/plain" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/markdown" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/json" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/x-yaml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/x-yaml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/toml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/x-toml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/xml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/xml" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/x-nix" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/x-nix" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/csv" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/x-log" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/javascript" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/javascript" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "application/x-sh" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];
        "text/x-shellscript" = [
          "org.gnome.TextEditor.desktop"
          "code.desktop"
        ];

        "image/jpeg" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/png" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/gif" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/webp" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/bmp" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/tiff" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/svg+xml" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/avif" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];
        "image/heic" = [
          "org.gnome.Loupe.desktop"
          "org.gnome.eog.desktop"
        ];

        "video/mp4" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/x-matroska" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/webm" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/quicktime" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/x-msvideo" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/x-ms-wmv" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/mpeg" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/ogg" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/3gpp" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/3gpp2" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];
        "video/mkv" = [
          "org.videolan.VLC.desktop"
          "org.gnome.Totem.desktop"
        ];

        "text/html" = [ "brave-browser.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];

        "application/pdf" = [ "brave-browser.desktop" ];
      };
    };
  };

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
