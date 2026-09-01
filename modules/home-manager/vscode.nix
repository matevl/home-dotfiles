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
        # --- Programming Languages ---
        # Rust
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        usernamehw.errorlens
        fill-labs.dependi

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

        # --- General productivity ---
        # Better Comments
        aaron-bond.better-comments
      ];
      userSettings = {
        # --- Window & General ---
        "window.titleBarStyle" = "native";
        "telemetry.telemetryLevel" = "off";

        # --- Editor ---
        "editor.fontSize" = 14;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "editor.codeActionsOnSave" = {
          "source.fixAll.clippy" = "explicit";
          "source.organizeImports" = "explicit";
        };

        # --- Terminal ---
        "terminal.integrated.defaultProfile.linux" = "zsh";

        # --- Rust (rust-analyzer) ---
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "editor.formatOnSave" = true;
        };
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.check.extraArgs" = [
          "--all-targets"
          "--all-features"
        ];
        "rust-analyzer.hover.documentation.enable" = true;
        "rust-analyzer.inlayHints.enable" = true;
        "rust-analyzer.inlayHints.parameterHints.enable" = true;
        "rust-analyzer.inlayHints.typeHints.enable" = true;
        "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "always";
        "rust-analyzer.diagnostics.enable" = true;
        "rust-analyzer.diagnostics.warningsAsHint" = [ ];
        "rust-analyzer.procMacro.enable" = true;

        # --- CodeLLDB (Debugging) ---
        "lldb.displayFormat" = "auto";
        "lldb.sourceLanguages" = [ "rust" ];

        # --- Error Lens ---
        "errorLens.enabledDiagnosticLevels" = [
          "warning"
          "error"
        ];
        "errorLens.followCursorMorecarefully" = true;
      };
    };
  };
}
