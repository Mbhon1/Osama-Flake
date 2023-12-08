{ pkgs, ... }:
{
  home.packages = with pkgs; [
    winetricks
    appimage-run
    protontricks 
    # NOTE: For most of my gaming I try to use flatpaks,
    # these are just reminders for what I need to iinstall from flathub.org.
    # bottles
    # wineWowPackages.stable
    # lutris
    # yuzu-early-access 
    # rpcs3 
    # heroic 
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

}
