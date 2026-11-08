{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    # Languages
    languagePacks = [
      "fr"
      "en-US"
    ];

    policies = {
      # Telemetry and studies
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      # No sponsored suggestions or recommendations
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        WhatsNew = false;
      };

      # No AI features
      GenerativeAI = {
        Enabled = false;
        Chatbot = false;
        LinkPreviews = false;
        TabGroups = false;
        Locked = true;
      };

      # uBlock Origin
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      isDefault = true;

      # DuckDuckGo without AI
      search = {
        force = true;
        default = "DuckDuckGo (sans IA)";
        privateDefault = "DuckDuckGo (sans IA)";
        order = [ "DuckDuckGo (sans IA)" ];

        engines = {
          "DuckDuckGo (sans IA)" = {
            urls = [
              {
                template = "https://noai.duckduckgo.com/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
              {
                template = "https://ac.duckduckgo.com/ac/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "type";
                    value = "list";
                  }
                ];
                type = "application/x-suggestions+json";
              }
            ];
            definedAliases = [ "@ddg" ];
          };

          # Hide the default engines
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };

      settings = {
        # Telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        # New tab page
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "extensions.pocket.enabled" = false;

        # AI
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.sidebar" = false;
        "browser.ml.chat.shortcuts" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "extensions.ml.enabled" = false;

        # Interface in French, English as fallback
        "intl.locale.requested" = "fr,en-US";
        "intl.accept_languages" = "fr-FR, fr, en-US, en";

        # Search suggestions from DuckDuckGo
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = true;
        "browser.urlbar.autocomplete.enabled" = true;

        "layout.css.prefers-color-scheme.content-override" = 0;
      };
    };
  };
}
