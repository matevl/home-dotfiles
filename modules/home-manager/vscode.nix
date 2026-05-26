{ pkgs-unstable, ... }:

{
  # VS Code
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode.override {
      commandLineArgs = "--disable-features=WaylandPerSurfaceScale";
    };
    profiles.default = {
      extensions = with pkgs-unstable.vscode-extensions; [
        # --- Code extensions ---
        # Python
        ms-python.python
        ms-python.vscode-pylance

        # Godot
        geequlim.godot-tools

        # Nix
        jnoortheen.nix-ide
        mkhl.direnv

        # C++
        ms-vscode.cpptools
        ms-vscode.makefile-tools
        ms-vscode.cmake-tools

        # --- Data & Formats ---
        # CSV
        mechatroner.rainbow-csv
        # XML
        redhat.vscode-xml
        # YML
        redhat.vscode-yaml
        # TOML
        tamasfe.even-better-toml

        # Docker
        ms-azuretools.vscode-docker

        # PDF viewer
        tomoki1207.pdf

        # Typst
        myriad-dreamin.tinymist

        # Markdown
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "window.titleBarStyle" = "native";
        "editor.fontSize" = 14;
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "telemetry.telemetryLevel" = "off";
      };
    };
  };
}
