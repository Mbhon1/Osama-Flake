{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;
    settings = {
      dynamic_background_opacity = "yes";
      background_opacity = "0.7";
      cursor_shame = "beam";
      font_family = "JetBrainsMono Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      font_size = "14.0";
      allow_remote_control = "yes";
      listen_on = "unix:@mykitty";
      confirm_os_window_close = 0;
      #copy_on_select = "clipboard";
      clipboard_control = "write-clipboard write-primary no-append";
      enable_audio_bell = "yes";
      visual_bell_duration = "0.6";
      visual_bell_color = "none";
      window_alert_on_bell = "yes";
      bell_on_tab = "🔔";
      detect_urls = "yes";
      show_hyperlink_targets = "yes";
      copy_on_select = "yes";
      mouse_hide_wait = "3.0";
      url_color = "#0087bd";
      url_style = "curly";
      open_url_with = "default";
      tab_bar_edge = "top";
      tab_bar_margin_width = "0.0";
      tab_bar_margin_height = "0.0 0.0";
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "round";
    };
    environment = {
      #THEME = "gruvbox";
      #NVIM_STATUSLINE = "rocket-line";
      #TMUX_STATUSLINE = "cleanline";
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    extraConfig = ''
      include ./themes/gruvbox.conf
      '';
  };

  xdg.configFile."kitty/themes/gruvbox.conf".text = import ./gruvbox.nix; 
  xdg.dataFile."kitty/themes" = {
    source = ./themes;
    recursive = true;
  };
  xdg.configFile."kitty/kitty.conf".text = ''
    include ./kitty.conf
    env THEME=gruvbox
    '';
  # xdg.dataFile."fonts/FantasqueSansMono.tff".source = ./FantasqueSansMono.tff;
  # xdg.dataFile."fonts/FantasqueSansMono" = {
  #   source = ./FantasqueSansMono;
  #   recursive = true;
  # };
}
