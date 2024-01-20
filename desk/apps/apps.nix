{ pkgs, config, ... }:
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
    anydesk
    libre
  ];

  nixpkgs.overlays = [
    ( final: prev: { b = final.brave; })
  ];

  programs = {
    brave.enable = true;
    browserpass.enable = true;
    browserpass.browsers = ["brave"];
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions ( exts: [exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
        PASSWORD_STORE_GPG_OPTS = "--no-throw-keyids";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      };
    };
    #TODO: obs-studio = {
    #   enable = true;
    #   plugins = [
    #     pkgs.obs-studio-plugins.obs-gstreamer
    #     pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    #     pkgs.obs-studio-plugins.obs-vkcapture
    #     pkgs.obs-studio-plugins.wlrobs
    #   ];
    # };
  };

}
