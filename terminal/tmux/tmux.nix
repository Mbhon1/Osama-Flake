{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  # xdg.configFile."~/.tmux.conf".text =''

  #   '';
}
