{ ... }:

{
  # Zen Browser from the zen-browser flake, also sets it as default browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Common Browser policies (locked)
    policies = {
      AutofillAdressEnabled = false;
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
      };
    };
  };
}
