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
    obsidian
    # NOTE: I use the flatpak version - 
    # whatsapp-for-linux
    # steam
    # obs-studio
    # obs-studio-plugins.wlrobs
    # wineWowPackages.stable
    bottles
    winetricks
    mailspring
    appimage-run
    # (
    # let base = pkgs.appimageTools.defaultFhsEnvArgs;
    # in pkgs.buildFHSUserEnv (base
    #  {
    #    name = "fhs";
    #    targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [ pkgs.pkg-config ];
    #    profile = "export FHS=1";
    #    runScript = "bash";
    #    extraOutputsToInstall = [ "dev" ];
    #  })
    # )
    
  ];

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = [
  #     pkgs.obs-studio-plugins.obs-gstreamer
  #     pkgs.obs-studio-plugins.obs-pipewire-audio-capture
  #     pkgs.obs-studio-plugins.obs-vkcapture
  #     pkgs.obs-studio-plugins.wlrobs
  #   ];
  # };
  # programs.steam.enable = true;
}
