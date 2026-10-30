{ ... }:

{
  # Zen Browser from the zen-browser flake, also sets it as default browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Common Browser policies (locked)
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # Zen locks the address bar shortcuts on, override that
      Preferences = {
        "browser.urlbar.suggest.topsites" = {
          Value = false;
          Status = "locked";
        };
      };

      # No Mozilla account / sync
      DisableFirefoxAccounts = true;

      # DuckDuckGo without AI as the only search engine
      SearchEngines = {
        Add = [
          {
            Name = "DuckDuckGo (no AI)";
            URLTemplate = "https://noai.duckduckgo.com/?q={searchTerms}";
            IconURL = "https://duckduckgo.com/favicon.ico";
            Alias = "@ddg";
          }
        ];
        Default = "DuckDuckGo (no AI)";
        Remove = [ "Google" "Bing" "DuckDuckGo" "Ecosia" "Qwant" "eBay" "Wikipedia (de)" "Wikipedia (en)" "Amazon.de" "Perplexity" ];
      };

      # Extensions
      ExtensionSettings = builtins.mapAttrs (_: slug: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        installation_mode = "force_installed";
      }) {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "addon@darkreader.org" = "darkreader";
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = "proton-pass";
      };

      # uBlock Origin filter lists (yokoffing's "Enhanced" setup)
      "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite.filterLists = [
        # uBO defaults
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-quick-fixes"
        "ublock-unbreak"
        "easylist"
        "easyprivacy"
        "urlhaus-1"
        "plowe-0"
        "DEU-0" # EasyList Germany
        # yokoffing additions
        "adguard-spyware-url"
        "fanboy-cookiemonster"
        "ublock-cookies-easylist"
        "fanboy-social"
        "ublock-annoyances"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
      ];
    };

    profiles.default = {
      # Betterfox: privacy, telemetry and performance prefs
      presets.betterfox.enable = true;

      # prefs (user.js)
      settings = {
        "zen.library.enabled" = false;
        "zen.urlbar.open-on-startup" = false;
        "zen.widget.linux.transparency" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "zen.welcome-screen.seen" = true;
        "zen.view.use-single-toolbar" = false;
        "zen.view.sidebar-expanded" = true;
        "zen.glance.open-essential-external-links" = false;
        "browser.profiles.enabled" = false;
        "browser.translations.neverTranslateLanguages" = "de,en";
        "browser.translations.automaticallyPopup" = false;
        "zen.theme.hide-unified-extensions-button" = true;
        "places.history.enabled" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.clipboard" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "zen.urlbar.suggestions.quick-actions" = false;
        "browser.topsites.useRemoteSetting" = false;
        "browser.newtabpage.pinned" = "[]";
        "general.autoScroll" = true;
      };

      # Zen mods
      mods = [
        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
        "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
      ];

      # Toolbar: only Proton Pass pinned
      extensionButtons = {
        "nav-bar" = [ "78272b6fa58f4a1abaac99321d503a20@proton.me" ];
        "unified-extensions-area" = [ "uBlock0@raymondhill.net" ];
      };
    };
  };
}
