{
  pkgs,
  pkgs-unstable,
  osConfig,
  ...
}:

{
  xdg =
    let
      # Apps
      editors = [
        "org.gnome.TextEditor.desktop"
        "code.desktop"
        "codium.desktop"
        "Helix.desktop"
      ];
      images = [
        "org.gnome.Loupe.desktop"
        "org.gnome.eog.desktop"
      ];
      videos = [
        "vlc.desktop"
        "org.gnome.Showtime.desktop"
      ];
      browser = [ "brave-browser.desktop" ];

      # Text Types
      textTypes = [
        # Text files
        "text/plain"
        "text/markdown"
        "text/csv"
        "text/x-log"

        # Config files
        "application/json"
        "application/xml"
        "application/yaml"
        "application/toml"

        # Scripts files
        "application/x-shellscript"

        # Web
        "text/javascript"
        "text/css"

        # C/C++
        "text/x-csrc"
        "text/x-chdr"
        "text/x-c++src"
        "text/x-c++hdr"

        # other
        "text/x-java"
        "text/rust"
        "text/x-go"
        "text/x-python"
        "text/x-python3"
      ];

      imageTypes = [
        "image/jpeg"
        "image/png"
        "image/gif"
        "image/webp"
        "image/bmp"
        "image/tiff"
        "image/svg+xml"
        "image/avif"
        "image/heif"
      ];

      videoTypes = [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/vnd.avi"
        "video/x-ms-wmv"
        "video/mpeg"
        "video/ogg"
        "video/3gpp"
        "video/3gpp2"
      ];

      browserTypes = [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    in
    {
      enable = true;
      configFile = {
        "mimeapps.list".force = true;
        "DankMaterialShell/settings.json".text = builtins.toJSON {
          wallpaper = osConfig.mySettings.wallpaper;
          background.type = "image";
          background.mode = "fill";
          session.lock.enable = false;
        };
      };
      dataFile."applications/mimeapps.list".force = true;

      mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
          "application/pdf" = browser;
        }
        // (pkgs.lib.genAttrs textTypes (_: editors))
        // (pkgs.lib.genAttrs imageTypes (_: images))
        // (pkgs.lib.genAttrs videoTypes (_: videos))
        // (pkgs.lib.genAttrs browserTypes (_: browser));
      };
    };

  # Chromium / Brave
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    #commandLineArgs = [ "--disable-features=WaylandPerSurfaceScale" ];
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
