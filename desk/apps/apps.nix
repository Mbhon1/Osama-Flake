{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    brave
    vscode
    firefox
    github-desktop
    discord
    betterdiscordctl
    obsidian
    gparted
  #  mailspring
  ];

  programs.brave.enable = true;
  programs.browserpass.enable = true;
  programs.browserpass.browsers = ["brave"];
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions ( exts: [exts.pass-otp ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
      PASSWORD_STORE_GPG_OPTS = "--no-throw-keyids";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };
  };

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = [
  #     pkgs.obs-studio-plugins.obs-gstreamer
  #     pkgs.obs-studio-plugins.obs-pipewire-audio-capture
  #     pkgs.obs-studio-plugins.obs-vkcapture
  #     pkgs.obs-studio-plugins.wlrobs
  #   ];
  # };

  # services.kdeconnect.indicator = true;
  # systemd.user.services.kdeconnect-indicator.Service.Environment = lib.mkForce [
  #   "LANG=en_US.UTF-8"
  #   "LC_ALL=en_US.UTF-8"
  #   "PATH=${config.home.profileDirectory}/bin"
  #   "QT_PLUGIN_PATH=/run/current-system/sw/${pkgs.qt5.qtbase.qtPluginPrefix}"
  # ];
  # systemd.user.services.kdeconnect-indicator.Unit.After = ["graphical-session.target" "desktop-panel.service"];
}
