{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [ cava ];

  home.file.".config/cava/config".text = ''
    #custom cava config
    "cava": {
//        "cava_config": "$XDG_CONFIG_HOME/cava/cava.conf",
        "framerate": 60,
        "autosens": 1,
        "sensitivity": 100,
        "bars": 14,
        "lower_cutoff_freq": 50,
        "higher_cutoff_freq": 10000,
        "method": "pulse",
        "source": "auto",
        "stereo": true,
        "reverse": false,
        "bar_delimiter": 0,
        "monstercat": false,
        "waves": false,
        "noise_reduction": 0.77,
        "input_delay": 2,
        "format-icons" : ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ],
        "actions": {
          "on-click-right": "mode"
        }
    }
    '';
}