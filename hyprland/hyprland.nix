{ pkgs, ... }:
{

  home.packages = with pkgs; [
    chezmoi
    neofetch
    onefetch
    zathura
    rofi
    rofi-emoji
    wofi
    bat
    jq
    cava
    swww
    xdg-desktop-portal-hyprland
    ffmpeg
    spicetify-cli
    wl-gammactl 
    wl-clipboard 
    wf-recorder
    hyprpicker 
    wayshot 
    imagemagick
    pavucontrol 
    brightnessctl
    socat
    xfce.thunar
    xfce.thunar-archive-plugin
    gnome.nautilus
    lxappearance
    pavucontrol
    mpv
    sassc
    supergfxctl
    hyprpicker
    slurp
    gnome.gnome-bluetooth
    wireplumber
    pipewire
    gsettings-desktop-schemas
    libnotify
    usbutils
    playerctl
    vulkan-tools
    glxinfo
    libva-utils
    xdg-utils
    xdg-user-dirs
    qt6.qtwayland
  ];

  services.udiskie.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      theme_background = false;
    };
  };

  programs.rofi.enable = true;
  programs.wofi.enable = true;

  services.playerctld.enable = true;

  home.file.".config/cava/config".text = ''
    #custom cava config
    "cava": {
//        "cava_config": "$XDG_CONFIG_HOME/cava/cava.conf",
        "framerate": 60,
        "autosens": 1,
        "sensitivity": 100,
        "bars": 14,
        "lower_cutoff_freq": 50,
        "higher_cutoff_freq": 10000,
        "method": "pulse",
        "source": "auto",
        "stereo": true,
        "reverse": false,
        "bar_delimiter": 0,
        "monstercat": false,
        "waves": false,
        "noise_reduction": 0.77,
        "input_delay": 2,
        "format-icons" : ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ],
        "actions": {
          "on-click-right": "mode"
        }
    }
    '';


  home.file = {
    ".local/bin/hypr" = {
      executable = true;
      text = ''
      #!/bin/sh
        export WLR_NO_HARDWARE_CURSORS=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"; fi

        if ! [[ "$PATH" =~ "$HOME/.nix-profile/bin:" ]]; then
          PATH="$HOME/.nix-profile/bin:$PATH"; fi

        export PATH
        # exec nixGL ${pkgs.hyprland}/bin/Hyprland
        exec /usr/bin/Hyprland
      '';
    };
  };

  home.file.".config/hypr/hyprland.conf.bak".text = '''';

  home.file.".config/hypr/start.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        swww daemon &
        swww init & 
        swww img ~/Pictures/swww-walls/W14_Car_Studio_2.jpg &
        '';
  };
}
