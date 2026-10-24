{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/gaming.nix
    ./modules/apps.nix
    ./home
  ];

  # ─── Nix ───
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and the new nix CLI
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # No channels, nixpkgs comes from the flake
  nix.channel.enable = false;

  # Deduplicate the Nix store
  nix.optimise.automatic = true;

  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # DO NOT CHANGE THIS VALUE!
  system.stateVersion = "26.05";
}
