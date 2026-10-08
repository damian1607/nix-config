# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."damian" = {
    isNormalUser = true;
    description = "Damian";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      spotify
      discord
      plex-desktop
    ];
  };
  
  # Fonts
  fonts.packages = with pkgs; [ noto-fonts noto-fonts-color-emoji nerd-fonts.jetbrains-mono ];

  # Font fallback order
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
    serif = [ "Noto Serif" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };

  # Force Electron-Apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Cursor for X11 apps (via xwayland-satellite), taken from home.pointerCursor in home.nix.
  # The DMS cursor setting still has to be changed by hand.
  environment.sessionVariables.XCURSOR_THEME = config.home-manager.users.damian.home.pointerCursor.name;
  environment.sessionVariables.XCURSOR_SIZE = toString config.home-manager.users.damian.home.pointerCursor.size;
  
  # Gaming
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.extraCompatPackages = [ pkgs.proton-ge-bin ];
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.enableRedistributableFirmware = true;

  # Flatpak Support
  services.flatpak.enable = true;

  # Enable fish shell (has to be set per user)
  programs.fish.enable = true;

  # Enable Starship shell
  programs.starship.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Deduplicate the Nix Store
  nix.optimise.automatic = true;

  # Niri and DankMaterialShell 
  programs.niri.enable = true;

  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = false;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/damian";
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    gh
    alacritty
    fastfetch
    nautilus
    pwvucontrol
    easyeffects
    vscodium
    celluloid
    papers
    mangohud
    mangojuice
    prismlauncher
    heroic
    xwayland-satellite
    adwaita-icon-theme
    ffmpegthumbnailer
    loupe
    capitaine-cursors
  ];

  # Zram Swap
  zramSwap.enable = true;
  
  # SSD Trim
  services.fstrim.enable = true;
  
  # Gnome Dconf and Virtual Filesystem
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # Garbage Collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  boot.loader.systemd-boot.configurationLimit = 5;
  
  # PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # DO NOT CHANGE THIS VALUE!
  system.stateVersion = "26.05";

}
