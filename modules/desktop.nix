{ config, pkgs, ... }:

let
  cursor = config.home-manager.users.damian.home.pointerCursor;
in
{
  # ─── niri and noctalia ───
  programs.niri.enable = true;

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  # Noctalia Greeter on greetd
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings.keyboard.layout = "de";
    passwordlessSyncUsers = [ "damian" ];
    cursorTheme = {
      package = cursor.package;
      name = cursor.name;
    };
  };

  # Gnome dconf and virtual filesystem
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  services.flatpak.enable = true;

  environment.sessionVariables = {
    # Force Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";

    # Cursor for X11 apps (via xwayland-satellite), taken from home.pointerCursor in home/desktop.nix
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
