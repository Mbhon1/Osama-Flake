{pkgs,...}:
{
  home.packages = with pkgs; [
  (nerdfonts.override { fonts = [
  "JetBrainsMono"
  "FiraCode"
  "FantasqueSansMono"
  "CascadiaCode"
  # "noto-fonts" 
  # "noto-fonts-cjk" 
  # "noto-fonts-emoji" 
  # "noto-fonts-extra"
  ]; })
  font-awesome
  material-design-icons
  qogir-theme
  papirus-icon-theme
  qogir-icon-theme
  whitesur-icon-theme
  colloid-icon-theme
  gruvbox-dark-icons-gtk
  gruvbox-gtk-theme
  ];

  home = {
    pointerCursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
      gtk.enable = true;
    };
  };

  gtk = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    cursorTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };
    iconTheme = {
      name = "Gruvbox Dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    gtk2 = {
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
    gtk3.extraConfig = { 
      gtk-application-prefer-dark-theme = 1; 
    };
    gtk4.extraConfig = { 
      gtk-application-prefer-dark-theme = 1; 
    };
  };

  # FIXME: all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  # fonts = {
  #   # use fonts specified by user rather than default ones
  #   enableDefaultFonts = false;
  #   fontDir.enable = true;

  #   fonts = with pkgs; [
  #     # icon fonts
  #     material-design-icons
  #     font-awesome

  #     noto-fonts 
  #     noto-fonts-cjk 
  #     noto-fonts-emoji 
  #     noto-fonts-extra 

  #     source-sans 
  #     source-serif
  #     source-han-sans
  #     source-han-serif 

  #     # nerdfonts
  #     (nerdfonts.override {
  #       fonts = [
  #         "FiraCode"
  #         "JetBrainsMono"
  #         "Iosevka"
  #       ];
  #     })

  #     # (pkgs.callPackage ../../fonts/icomoon-feather-icon-font.nix {})
  #   ];

  #   fontconfig.defaultFonts = {
  #     serif = ["Noto Serif" "Noto Color Emoji"];
  #     sansSerif = ["Noto Sans" "Noto Color Emoji"];
  #     monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
  #     emoji = ["Noto Color Emoji"];
  #   };
  # };
  
  # TODO: find how to set dark mode
}
