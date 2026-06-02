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
        {
          name = "python";
          language-servers = [ "pylsp" ];
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "typescript";
          language-servers = [ "typescript-language-server" ];
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" ];
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
        }
        {
          name = "c";
          language-servers = [ "clangd" ];
        }
        {
          name = "gdscript";
          language-servers = [ "godot" ];
        }
        {
          name = "xml";
          language-servers = [ "lemminx" ];
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
        }
        {
          name = "toml";
          language-servers = [ "taplo" ];
        }
      ];

      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        pylsp = {
          command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
        };
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        };
        typescript-language-server = {
          command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };
        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
        };
        godot = {
          command = "${pkgs.netcat}/bin/nc";
          args = [
            "127.0.0.1"
            "6005"
          ];
        };
        lemminx = {
          command = "${pkgs.lemminx}/bin/lemminx";
        };
        yaml-language-server = {
          command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
          args = [ "--stdio" ];
        };
        taplo = {
          command = "${pkgs.taplo}/bin/taplo";
          args = [
            "lsp"
            "stdio"
          ];
        };
      };
    };
  };
}
