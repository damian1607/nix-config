{ pkgs, ... }:

{
  # Steam also enables hardware.graphics (incl. 32-bit)
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    package = pkgs.steam.override {
      extraEnv = {
        PROTON_ENABLE_WAYLAND = "1";
        PROTON_FSR4_UPGRADE = "1";
        MANGOHUD = "1";
      };
    };
  };

  # German keyboard layout inside gamescope (it defaults to US)
  environment.sessionVariables.XKB_DEFAULT_LAYOUT = "de";

  environment.systemPackages = with pkgs; [
    mangohud
    prismlauncher
    heroic
  ];
}
