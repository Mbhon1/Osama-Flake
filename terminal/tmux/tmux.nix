{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  home.file."/home/mbhon1/.tmux/" = {
    source = ./tmux;
  };

  home.file."/home/mbhon1/.tmux.conf".text =''
     # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'erikw/tmux-powerline'
      set -g @plugin 'thewtex/tmux-mem-cpu-load'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      set -g @t-fzf-promt ' '
      set -g @plugin 'joshmedeski/t-smart-tmux-session-manager'

      # FIXME: set -g status-right '#[fg=green]#($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load --colors --powerline-right --interval 2)#[default]'
      # Options
      set -g default-terminal "screen-256color"
      set -g mouse on

      # leader key
      set -g prefix C-a

      set-window-option -g mode-keys vi

      set -g status-position top
      set -g status-interval 2
      set -g status-style 'bg=default'

      # Keybinds

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # leader key
      unbind C-b
      bind-key C-a send-prefix

      # Hoz split
      unbind %
      bind | split-window -h

      # Vert split
      unbind '"'
      bind - split-window -v

      # source-file refresh
      bind r source-file ~/.tmux.conf

      # resize windows
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      bind -r m resize-pane -Z

      bind -r m resize-pane -Z


      run '~/.tmux/plugins/tpm/tpm' 
    '';
}
