{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    tmux
    powerline
    tmux-mem-cpu-load
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-Space";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tmuxPlugins.gruvbox
    ];

    extraConfig = ''
      # set -g default-terminal "screen-256color"
      set -g mouse on

      # leader key
      # set -g prefix C-a

      set-window-option -g mode-keys vi

      set -g status-position top
      set -g status-interval 2
      set -g status-style 'bg=default'

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # leader key
      # unbind C-b
      # bind-key C-a send-prefix

      # Hoz split
      unbind %
      bind | split-window -h

      # Vert split
      unbind '"'
      bind - split-window -v

      # source-file refresh
      # bind r source-file ~/.tmux.conf

      # resize windows
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      bind -r m resize-pane -Z

      bind -r m resize-pane -Z 

    '';
  };
}
