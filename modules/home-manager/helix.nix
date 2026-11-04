{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nixd
      python3Packages.python-lsp-server
      rust-analyzer
      clang-tools
      netcat
      lemminx
      yaml-language-server
      taplo
    ];

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
        }
        {
          name = "javascript";
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
        lemminx.command = "lemminx";
        godot = {
          command = "nc";
          args = [
            "127.0.0.1"
            "6005"
          ];
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = [ "--stdio" ];
        };
        taplo = {
          command = "taplo";
          args = [
            "lsp"
            "stdio"
          ];
        };
      };
    };
  };
}
