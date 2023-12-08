{ pkgs, ... }:
{

  home.packages = with pkgs; [
    neofetch
    onefetch
    zathura
    rofi
    rofi-emoji
    bat
    jq
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
    pulsemixer
    imv
  ];

  services = {
    udiskie.enable = true;
    playerctld.enable = true;
  };

  programs = {
    rofi.enable = true;
    wofi.enable = true;
  };


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

}
