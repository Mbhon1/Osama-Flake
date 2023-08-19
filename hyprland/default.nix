{ pkgs, config, ... }:
{
  imports = [
    ./hyprland.nix
    #./config.nix
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = DP-1, 1440x900@59, 0x0, 1

    # Start up apps on boot
    exec-once = /usr/libexec/polkit-gnome-authentication-agent-1
    exec-once = ags
    exec-once = ~/.profile
    # exec-once = flatpak run com.transmissionbt.Transmission
    exec-once = swww init
    exec-once = wl-paste --type text --watch cliphist store #Stores only text data
    # exec-once = wl-paste --type image --watch cliphist store #Stores only image data
    exec-once = wl-paste --type image --watch

    # Settings
    general {
      layout = dwindle
      resize_on_border = true
    }

    misc {
      layers_hog_keyboard_focus = false
      layers_hog_keyboard_focus = true
      disable_splash_rendering = true
    }

    input {
      kb_layout = us
      kb_model = pc104
      follow_mouse = 1
      touchpad {
        natural_scroll = yes
      }
      sensitivity = 0
    }

    binds {
      allow_workspace_cycles = true
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes
      # no_gaps_when_only = yes
    }

    master {
      new_is_master = false
      # no_gaps_when_only = yes
    }

    gestures {
      workspace_swipe = on
    }

    # Theme
    decoration {
      drop_shadow = yes
      shadow_range = 8
      shadow_render_power = 2
      col.shadow = rgba(00000044)

      dim_inactive = false

      #blur {
        # enabled = true
        #size = 8
        #passes = 3
        #new_optimizations = on
        #noise = 0.01
        #contrast = 0.9
        #brightness = 0.8
      }
    }

    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 5, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    plugin {
      hyprbars {
        bar_color = rgb(2a2a2a)
        bar_height = 28
        col_text = rgba(ffffffdd)
        bar_text_size = 11
        bar_text_font = Ubuntu Nerd Font 
        buttons {
          button_size = 11
          col.maximize = rgba(ffffff11)
          col.close = rgba(ff111133)
        }
      }
    }

    # Window rules
    windowrule = float, ^(Rofi)$
    windowrule = float, ^(org.gnome.Calculator)$
    windowrule = float, ^(thunar)$
    windowrule = float, ^(eww)$
    windowrule = float, ^(pavucontrol)$
    windowrule = float, ^(nm-connection-editor)$
    windowrule = float, ^(blueberry.py)$
    windowrule = float, ^(org.gnome.Settings)$
    windowrule = float, ^(org.gnome.design.Palette)$
    windowrule = float, ^(Color Picker)$
    windowrule = float, ^(Network)$
    windowrule = float, ^(xdg-desktop-portal)$
    windowrule = float, ^(xdg-desktop-portal-gnome)$
    windowrule = float, ^(transmission-gtk)$
    windowrule = float, ^(ags)$

    # Keybinds
    $main = SUPER
    $meta = ALT

    # AGS
    bind = CTRL SHIFT, R, exec, pkill ags ; ags
    bind = SUPER, D, exec, ags toggle-window overview
    bind = , XF86PowerOff, exec, ags toggle-window powermenu
    bind = SUPER, SPACE, exec, ags toggle-window applauncher
    bind  = , XF86Launch4, exec, ags run-js "ags.Service.Recorder.start()"
    # bind  = , XF86Launch1, exec, 

    # Print
    # Laptop
    bindle = , XF86MonBrightnessUp,     exec, ags run-js "ags.Service.Brightness.screen += 0.02; ags.Service.Indicator.display()"
    bindle = , XF86MonBrightnessDown,   exec, ags run-js "ags.Service.Brightness.screen -= 0.02; ags.Service.Indicator.display()"
    bindle = , XF86KbdBrightnessUp,     exec, ags run-js "ags.Service.Brightness.kbd++; ags.Service.Indicator.kbd()"
    bindle = , XF86KbdBrightnessDown,   exec, ags run-js "ags.Service.Brightness.kbd--; ags.Service.Indicator.kbd()"
    bindle = , XF86AudioRaiseVolume,    exec, ags run-js "ags.Service.Audio.speaker.volume += 0.05; ags.Service.Indicator.speaker()"
    bindle = , XF86AudioLowerVolume,    exec, ags run-js "ags.Service.Audio.speaker.volume -= 0.05; ags.Service.Indicator.speaker()"
    bindl  = , XF86AudioPlay,           exec, ags run-js "ags.Service.Mpris.getPlayer()?.playPause()"
    bindl  = , XF86AudioStop,           exec, ags run-js "ags.Service.Mpris.getPlayer()?.stop()"
    bindl  = , XF86AudioPause,          exec, ags run-js "ags.Service.Mpris.getPlayer()?.pause()"
    bindl  = , XF86AudioPrev,           exec, ags run-js "ags.Service.Mpris.getPlayer()?.previous()"
    bindl  = , XF86AudioNext,           exec, ags run-js "ags.Service.Mpris.getPlayer()?.next()"
    bindl  = , XF86AudioMicMute,        exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle

    bind = ,Print, exec, ags run-js "ags.Service.Recorder.screenshot()"
    # bind = , Print, exec, sleep 1 && grimblast --notify save area ~/Pictures/Screenshots/$(date +'%s_screenshot.png') &
    bind = ,SHIFT Print, exec, wf-recorder --audio --file=/home/mbhon1/Pictures/Screenshots/$(date +'%s_screenrecord.mp4') &


    # Launchers
    bind = SUPER, Return, exec, kitty
    bind = SUPER, W, exec, brave
    bind = SUPER, E, exec, nautilus
    bind = SUPER, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
    bind = ALT, G, exec, rofi -modi emoji -show emoji
    bind = ALT, W, exec, ~/.config/swww/changeWalls
    bind = ALT, L, exec, wlogout
    bind = ALT, SPACE, exec, pkill rofi || ~/.config/rofi/launchers/type-6/launcher.sh 

    # Bindings
    bind = CTRL ALT, Delete, exit
    bind = SUPER, Q, killactive
    bind = SUPER, F, togglefloating
    bind = SUPER, G, fullscreen
    bind = SUPER, O, fakefullscreen
    bind = SUPER, P, togglesplit

    # Move focus with mainMod + arrow keys
    bind = SUPER, k, movefocus, u
    bind = SUPER, j, movefocus, d
    bind = SUPER, l, movefocus, r
    bind = SUPER, h, movefocus, l

    # Switch workspaces with mainMod + [0-9]
    bind = SUPER, left,  workspace, e-1
    bind = SUPER, right, workspace, e+1
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9

    # Window
    binde = SUPER CTRL, k, resizeactive, 0 -20
    binde = SUPER CTRL, j, resizeactive, 0 20
    binde = SUPER CTRL, l, resizeactive, 20 0
    binde = SUPER CTRL, h, resizeactive, -20 0
    binde = SUPER ALT,  k, moveactive, 0 -20
    binde = SUPER ALT,  j, moveactive, 0 20
    binde = SUPER ALT,  l, moveactive, 20 0
    binde = SUPER ALT,  h, moveactive, -20 0

    # Move active window to workspace
    bind = SUPER SHIFT, right, movetoworkspace, e+1
    bind = SUPER SHIFT, left,  movetoworkspace, e-1
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
    '';
}
