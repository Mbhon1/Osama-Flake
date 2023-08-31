{ inputs, config, pkgs, lib, ... }:

{

  imports = [
  ./theming.nix
  ./hyprland
  ./apps.nix
  ./spicetify.nix
  ./terminal
  # ./utils
  ];
  

  home.username = "mbhon1";
  home.homeDirectory = "/home/mbhon1";
  home.file = {};
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

  home.packages = with pkgs; [
    nodejs
    rustc
    cargo
    go
    clang
    gnumake
    llvmPackages_9.libclang
    sassc
    meson
    ninja
    cmake
    pkg-config
    gobject-introspection-unwrapped
    nmon
    glib
    jdk8
    gnupatch
    git
    curl
    wget
    xdg-desktop-portal-gtk
    libsecret
    gawk
    nettools
    coreutils
    gnome.gnome-keyring
  ];

  dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
    };
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
}
