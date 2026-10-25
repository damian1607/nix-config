{ pkgs, ... }:

{
  # Steam also enables hardware.graphics (incl. 32-bit)
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # German keyboard layout inside gamescope (it defaults to US)
  environment.sessionVariables.XKB_DEFAULT_LAYOUT = "de";

  environment.systemPackages = with pkgs; [
    mangohud
    prismlauncher
    heroic
  ];
}
