{ pkgs, lib, config, ... }:
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
    lutris
    mailspring
    appimage-run
    yuzu-early-access # Nintendo Switch emulator
    rpcs3 # PS3 Emulator
    protontricks # Winetricks for proton prefixes
    heroic # Epic Games Launcher for Linux
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

  services.kdeconnect.indicator = true;
  systemd.user.services.kdeconnect-indicator.Service.Environment = lib.mkForce [
    "LANG=en_US.UTF-8"
    "LC_ALL=en_US.UTF-8"
    "PATH=${config.home.profileDirectory}/bin"
    "QT_PLUGIN_PATH=/run/current-system/sw/${pkgs.qt5.qtbase.qtPluginPrefix}"
  ];
  systemd.user.services.kdeconnect-indicator.Unit.After = ["graphical-session.target" "desktop-panel.service"];

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
