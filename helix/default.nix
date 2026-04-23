{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        color-modes = true;
        idle-timeout = 50;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "┊";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      keys.normal = {
        space.f.f = "file_picker";
        space.f.g = "global_search";
        space.f.b = "buffer_picker";
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
        }
      ];

      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
      };
    };
  };
}
