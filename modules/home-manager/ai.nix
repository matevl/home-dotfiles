{ osConfig, ... }:
{
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11434;

    acceleration = if osConfig.mySettings.nvidia.enable then "cuda" else false;

    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30m";
    };
  };

  programs.opencode = {
    enable = true;

    settings = {
      "$schema" = "https://opencode.ai/config.json";

      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://127.0.0.1:11434/v1";
        models = {
          "qwen2.5-coder:7b" = {
            name = "Qwen2.5 Coder 7B";
          };
        };
      };
    };
  };
}
