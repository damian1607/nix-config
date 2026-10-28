{ pkgs, ... }:

{
  # ─── Boot ───
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    maxGenerations = 5;
    enableEditor = false;

    # Tokyo Night
    style = {
      wallpapers = [];
      backdrop = "1a1b26";
      interface = {
        branding = "NixOS";
        brandingColor = "bb9af7";
        helpColor = "7aa2f7";
        helpColorBright = "8db0ff";
      };
      graphicalTerminal = {
        foreground = "c0caf5";
        background = "ff1a1b26";
        brightForeground = "c0caf5";
        brightBackground = "ff24283b";
        palette = "15161e;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;7dcfff;a9b1d6";
        brightPalette = "414868;ff899d;9fe044;faba4a;8db0ff;c7a9ff;a4daff;c0caf5";
      };
    };
  };

  # ─── Network, time and locale ───
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  # English UI with German formats
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Keyboard layout (niri sets its own in input.kdl)
  services.xserver.xkb.layout = "de";
  console.keyMap = "de";

  # ─── User ───
  # User packages live in apps.nix
  users.users."damian" = {
    isNormalUser = true;
    description = "Damian";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.fish;
  };

  # Enable fish shell (has to be set per user)
  programs.fish.enable = true;
  programs.starship.enable = true;

  # nvim as default editor (also for sudo -e)
  environment.variables.EDITOR = "nvim";

  # ─── System housekeeping ───
  zramSwap.enable = true;
  services.fstrim.enable = true;

  # Keep system logs small
  services.journald.settings.Journal.SystemMaxUse = "500M";

  # ─── Hardware ───
  # Wooting keyboard: installs Wootility and the udev rules for device access
  hardware.wooting.enable = true;

  # ─── Audio ───
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
