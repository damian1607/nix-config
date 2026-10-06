{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

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
    };
  };
}
