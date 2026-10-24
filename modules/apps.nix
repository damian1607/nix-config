{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture  # record audio from single apps
      obs-vkcapture               # game capture for Vulkan/OpenGL games
    ];
  };

  environment.systemPackages = with pkgs; [
    # Terminal and CLI
    alacritty
    fastfetch
    git
    gh
    wl-clipboard  # clipboard access for nvim under Wayland

    # Files and media
    nautilus
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
    (discord.override { withVencord = true; })
    plex-desktop
  ];
}
