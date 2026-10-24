{ ... }:

{
  # Zen Browser from the zen-browser flake, also sets it as default browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Betterfox: privacy, telemetry and performance prefs
    profiles.default.presets.betterfox.enable = true;
  };
}
