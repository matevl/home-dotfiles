{ lib, ... }:
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
      mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
          "application/pdf" = browser;
        }
        // (lib.genAttrs textTypes (_: editors))
        // (lib.genAttrs imageTypes (_: images))
        // (lib.genAttrs videoTypes (_: videos))
        // (lib.genAttrs browserTypes (_: browser));
      };
    };
}
