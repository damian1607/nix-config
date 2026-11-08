{ ... }:

{
  # Discord client with Vencord, plugins managed here
  programs.vesktop = {
    enable = true;

    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;

      plugins = {
        FakeNitro.enabled = true;
      };
    };
  };
}
