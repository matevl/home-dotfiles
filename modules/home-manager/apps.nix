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
        "hx.desktop"
      ];
      images = [
        "org.gnome.Loupe.desktop"
        "org.gnome.eog.desktop"
      ];
      videos = [
        "org.videolan.VLC.desktop"
        "org.gnome.Totem.desktop"
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
        "text/xml"
        "application/x-yaml"
        "text/x-yaml"
        "application/toml"
        "text/x-toml"

        # Scripts files
        "application/x-sh"
        "text/x-shellscript"
        "application/x-nix"
        "text/x-nix"

        # Web
        "application/javascript"
        "text/javascript"
        "application/typescript"
        "text/typescript"
        "text/css"

        # C/C++
        "text/x-c"
        "text/x-csrc"
        "text/x-chdr"
        "text/x-c++"
        "text/x-c++src"
        "text/x-c++hdr"

        # other
        "text/x-java"
        "text/rust"
        "text/x-rust"
        "text/x-go"
        "text/x-python"
        "application/x-python-code"
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
        "image/heic"
      ];

      videoTypes = [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/x-msvideo"
        "video/x-ms-wmv"
        "video/mpeg"
        "video/ogg"
        "video/3gpp"
        "video/3gpp2"
        "video/mkv"
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
    commandLineArgs = [ "--disable-features=WaylandPerSurfaceScale" ];
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
