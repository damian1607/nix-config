{ config, pkgs, ... }:

let
  cursor = config.home-manager.users.damian.home.pointerCursor;
in
{
  # ─── niri and DankMaterialShell ───
  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };

  # DankSearch: file search for the DMS launcher
  programs.dsearch = {
    enable = true;
    systemd.enable = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/damian";
  };

  # Gnome dconf and virtual filesystem
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  services.flatpak.enable = true;

  environment.sessionVariables = {
    # Force Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";

    # Cursor for X11 apps (via xwayland-satellite), taken from home.pointerCursor in home/desktop.nix.
    # The DMS cursor setting still has to be changed by hand.
    XCURSOR_THEME = cursor.name;
    XCURSOR_SIZE = toString cursor.size;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    adwaita-icon-theme
  ];

  # ─── Fonts ───
  fonts.packages = with pkgs; [ noto-fonts noto-fonts-color-emoji nerd-fonts.jetbrains-mono ];

  # Font fallback order
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
    serif = [ "Noto Serif" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
