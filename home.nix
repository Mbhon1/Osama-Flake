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
  

  home.username = "mbhon1";
  home.homeDirectory = "/home/mbhon1";
  home.stateVersion = "23.05"; 

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
    BROWSER = "brave";
    TERMINAL = "kitty";
    # SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file.".config/ags" = {
    source = ./ags;
  };

  nixpkgs = {
    overlays = [
      (self: super: {
      fcitx-engines = pkgs.fcitx5;
    })
      # (final: prev: {
      #    steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
      #          extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
      #           libgdiplus
      #          ]);
      #        });
      #  })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "openssl-1.1.1v" ];
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nix;

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovim.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    # "image/*" = [ "sxiv.desktop" ];
  };

  # services.flatpak.repos.flathub = "https://flathub.org/repo/flathub.flatpakrepo";
  # services.flatpak.packages = {
  #   flathub.io.Figma_Linux.figma_linux
  # };

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
}
