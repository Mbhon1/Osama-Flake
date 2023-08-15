{pkgs,...}:
{
  home.packages = with pkgs; [
  (nerdfonts.override { fonts = [
  "JetBrainsMono"
  "FiraCode"
  "FantasqueSansMono"
  "CascadiaCode"
  ]; })
  font-awesome

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
    font.name = "FantasqueSansMono Nerd Font";
    cursorTheme = {
      name = "Qogir";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    iconTheme = {
      name = "Gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
  
  # TODO: find how to set dark mode
  # gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  # gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
}
