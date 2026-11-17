{ pkgs, ... }:

{

  # Lightweight screen-recorder
  programs.gpu-screen-recorder.ui.enable = true;

  # JDK for java development
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # Terminal and CLI
    ghostty
    fastfetch
    git
    wl-clipboard  # clipboard access for nvim under Wayland
    eza
    bat

    # Files and media
    nautilus
    file-roller
    ffmpegthumbnailer
    baobab
    loupe
    celluloid
    papers
    parabolic
    upscaler

    # Audio
    pwvucontrol
    easyeffects

    # Editor
    vscodium
  ];

  # Only for my user
  users.users."damian".packages = with pkgs; [
    spotify
    plex-desktop
  ];
}
