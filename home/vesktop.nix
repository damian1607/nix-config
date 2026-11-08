{ ... }:

{
  # Discord client with Vencord, plugins managed here
  programs.vesktop = {
    enable = true;

    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;

      plugins = {
        DisableCallIdle.enabled = true;
        FakeNitro.enabled = true;
        ForceOwnerCrown.enabled = true;
        PlainFolderIcon.enabled = true;
        RelationshipNotifier.enabled = true;
      };
    };
  };
}
