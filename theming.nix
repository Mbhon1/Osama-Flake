{pkgs, ...}:
{
  home.packages = with pkgs; [
  (nerdfonts.override { fonts = [
  "JetBrainsMono"
  "FiraCode"
  "FantasqueSansMono"
  "CascadiaCode"
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
    font.name = "JetBrainsMono Nerd Font";
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
}
