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
  # Dotfiles as read-only symlinks
  xdg.configFile = {
    "niri/config.kdl".source = ../dotfiles/niri/config.kdl;
    "niri/modules".source = ../dotfiles/niri/modules;
    "fish/config.fish".source = ../dotfiles/fish/config.fish;
    "ghostty/config".source = ../dotfiles/ghostty/config;
    "fastfetch".source = ../dotfiles/fastfetch;
    "MangoHud/MangoHud.conf".source = ../dotfiles/MangoHud/MangoHud.conf;
    "noctalia/config.toml".source = ../dotfiles/noctalia/config.toml;
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
      # Files
      "inode/directory" = "org.gnome.Nautilus.desktop";
      # Text
      "text/plain" = "codium.desktop";
      "application/json" = "codium.desktop";
      # Documents
      "application/pdf" = "org.gnome.Papers.desktop";
      # Images
      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      # Video
      "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
      "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
      "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
      # Audio
      "audio/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
      "audio/flac" = "io.github.celluloid_player.Celluloid.desktop";
      "audio/ogg" = "io.github.celluloid_player.Celluloid.desktop";
      "audio/opus" = "io.github.celluloid_player.Celluloid.desktop";
      "audio/x-wav" = "io.github.celluloid_player.Celluloid.desktop";
      "audio/mp4" = "io.github.celluloid_player.Celluloid.desktop";
      # Archives
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/vnd.rar" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
      "application/gzip" = "org.gnome.FileRoller.desktop";
      "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-xz-compressed-tar" = "org.gnome.FileRoller.desktop";
      "application/x-zstd-compressed-tar" = "org.gnome.FileRoller.desktop";
    };
  };
}
