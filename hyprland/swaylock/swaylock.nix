{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ swaylock-effects ];

  # programs.swaylock = {
  #   enable = true;
  #   package = pkgs.swaylock-effects;
  #   settings = {
  #     daemonize = true;
  #     clock = true;
  #     show-failed-attempts = true;
  #     ignore-empty-password = true;
  #     indicator = true;
  #     screenshot = true;
  #     effect-blur = "9x9";
  #     font = "JetBrainsMono Nerd Font Mono";
  #     indicator-radius = "120";
  #     indicator-thickness = "16";
  #     line-color = "32302f";
  #     ring-color = "32302f";
  #     inside-color = "32302f";
  #     key-hl-color = "d3869b";
  #     separator-color = "00000000";
  #     text-color = "fbf1c7";
  #     line-ver-color = "83a598";
  #     ring-ver-color = "83a598";
  #     inside-ver-color = "83a598";
  #     ring-wrong-color = "fb4934";
  #     inside-wrong-color = "fb4934";
  #     inside-clear-color = "8ec07c";
  #     text-clear-color = "e0def4";
  #     ring-clear-color = "8ec07c";
  #     line-clear-color = "8ec07c";
  #     line-wrong-color = "fb4934";
  #     fade-in = "0.15";
  #   };
  # };
}
