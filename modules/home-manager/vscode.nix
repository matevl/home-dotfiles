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
        # Python
        ms-python.python
        ms-python.vscode-pylance

        # Godot
        geequlim.godot-tools

        # Nix
        jnoortheen.nix-ide

        # C++
        ms-vscode.cpptools
        ms-vscode.makefile-tools
        ms-vscode.cmake-tools

        # Data & Formats
        mechatroner.rainbow-csv
        redhat.vscode-xml
        redhat.vscode-yaml

        # Docker
        ms-azuretools.vscode-docker

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
