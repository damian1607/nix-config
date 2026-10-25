{ pkgs, ... }:

{
  # Cursor theme in ~/.icons, incl. ~/.icons/default for X11 apps
  home.pointerCursor = {
    enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
    gtk.enable = true;
  };
  gtk.enable = true;
  # Default apps
  xdg.configFile = {
    "niri/config.kdl".source = ../dotfiles/niri/config.kdl;
    "niri/modules".source = ../dotfiles/niri/modules;
    "fish/config.fish".source = ../dotfiles/fish/config.fish;
    "ghostty/config".source = ../dotfiles/ghostty/config;
    "fastfetch".source = ../dotfiles/fastfetch;
  };
  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    templates = null;    # don't need these two
    publicShare = null;
  };
  # Hide folders that apps create in ~ but I never use
  # Library: created by Plex Desktop on every start
  home.file.".hidden".text = ''
    Library
  '';
  # Default apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
      "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
      "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
      "application/pdf" = "org.gnome.Papers.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      # Overrides Zen's setAsDefaultBrowser
      "text/plain" = "codium.desktop";
      "application/json" = "codium.desktop";
    };
  };
}
