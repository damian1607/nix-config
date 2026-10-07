{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.damian = {
      home.stateVersion = "26.05";

      xdg.configFile = {
        "niri/config.kdl".source = ./dotfiles/niri/config.kdl;
        "niri/modules".source = ./dotfiles/niri/modules;
        "fish/config.fish".source = ./dotfiles/fish/config.fish;
        "alacritty/alacritty.toml".source = ./dotfiles/alacritty/alacritty.toml;
      };
      # XDG user directories
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        templates = null;    # don't need these two
        publicShare = null;
      };
      # Default apps
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = "org.gnome.Loupe.desktop";
          "image/jpeg" = "org.gnome.Loupe.desktop";
          "image/webp" = "org.gnome.Loupe.desktop";
          "image/gif" = "org.gnome.Loupe.desktop";
          "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
          "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
          "application/pdf" = "org.gnome.Papers.desktop";
          "inode/directory" = "org.gnome.Nautilus.desktop";
        };
      };
    };
  };
}
