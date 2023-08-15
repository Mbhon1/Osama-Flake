{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    zip
    brave
    unzip
    vscode
    firefox
    github-desktop
    discord
    betterdiscordctl
    betterdiscord-installer
    steam
    obsidian
    obs-studio
    obs-studio-plugins.wlrobs
    bottles
    wineWowPackages.stable
    winetricks
    whatsapp-for-linux
    virt-manager
    mailspring
  ];

  programs.obs-studio = {
    #enable = true;
    plugins = [
      pkgs.obs-studio-plugins.obs-gstreamer
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      # pkgs.obs-studio-plugins.obs-vkcapture
      pkgs.obs-studio-plugins.wlrobs
    ];
  };
 # programs.steam.enable = true;
}
