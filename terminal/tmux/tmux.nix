{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  # xdg.configFile."/home/mbhon1/.tmux.conf".text =''

  #   '';
}
