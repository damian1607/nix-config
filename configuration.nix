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

  # nh: nicer nixos-rebuild (also cleans older gens)
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 5";
    };
  };

  # DO NOT CHANGE THIS VALUE!
  system.stateVersion = "26.05";
}
