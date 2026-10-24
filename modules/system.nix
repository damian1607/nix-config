{ pkgs, ... }:

{
  # ─── Boot ───
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  # No kernel cmdline editing at boot (init=/bin/sh would give a root shell)
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

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
    extraGroups = [ "networkmanager" "wheel" "gamemode" "input" ];
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
