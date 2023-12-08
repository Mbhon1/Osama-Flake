{ inputs, config, pkgs, lib, ... }:

{

  imports = [
    ./theming.nix
    ./hyprland
    ./spicetify.nix
    ./terminal
    ./utils
    ./desk
    ./packages
  ];
  

  home = {
    username = "mbhon1";
    homeDirectory = "/home/mbhon1";
    stateVersion = "23.05"; 
    sessionVariables = {
      EDITOR = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
      BROWSER = "brave";
      TERMINAL = "kitty";
      # SHELL = "${pkgs.zsh}/bin/zsh";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
    # FIXME: trying to symlink ags so I can alter from home-manager
    # file.".config/ags.home" = {
    #   source = ./ags;
    # };
  };
  

  manual.manpages.enable = false;

  nixpkgs = {
    overlays = [
      (self: super: {
      fcitx-engines = pkgs.fcitx5;
      })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "openssl-1.1.1v" ];
    };
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nix;
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovim.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    # "image/*" = [ "sxiv.desktop" ];
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
