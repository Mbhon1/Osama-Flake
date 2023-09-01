{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [ swww ];

  home.file.".config/hypr/start.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        swww daemon &
        swww init & 
        swww img ~/Pictures/swww-walls/W14_Car_Studio_2.jpg &
        '';
  };

  home.file.".config/swww/changeWalls" = {
    executable = true;
    source = ./changeWalls;
  };
}
