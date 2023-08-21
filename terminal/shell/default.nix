{ pkgs, config, lib, ... }:
{
  imports = [
    ./starship
    ./zsh.nix
    ./zshrc.nix
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      "bg+" = "-1";
      "fg" = "-1";
      "fg+" = "-1";
      "prompt" = "6";
      "header" = "5";
      "pointer" = "2";
      "hl" = "2";
      "hl+" = "2";
      "spinner" = "05";
      "info" = "15";
      "border" = "15";
    };
    defaultOptions = ["--reverse" "--ansi"];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    icons = true;
    extraOptions = [ "--group-directories-first" "--header" ];
    git = true;
  };
}
