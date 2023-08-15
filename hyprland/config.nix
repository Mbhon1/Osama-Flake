{ config, default, ... }:
# let
#   inherit (default) colors;

#   pointer = config.home.pointerCursor;
#   homeDir = config.home.homeDirectory;
# in 
{
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      monitor = "DP-1, 1440x900@59, 0x0, 1";
      exec-once = [
        # "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # exec-once=dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP #&& systemctl --user start hyprland-session.target
        "/usr/libexec/polkit-gnome-authentication-agent-1"
        "ags"
        "~/.profile"
        # exec-once = flatpak run com.transmissionbt.Transmission
        #exec-once = hyprctl setcursor Qogir 24
        "swww init"
        "playerctld daemon"
        "$HOME/.config/swww/swww.sh"
        "~/.config/hypr/start.sh"
        # plugin = /usr/lib64/hyprland/libhyprbars.so
        # plugin = /usr/lib64/hyprland/libborders-plus-plus.so
        "xwaylandvideobridge"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
        #"echo 'Xft.dpi: 130' | xrdb -merge"
      ];
      xwayland = { force_zero_scaling = true; };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        force_no_accel = 1;
      };
      misc = {
        #disable_autoreload = true;
        #animate_mouse_windowdragging = false;
        #layers_hog_keyboard_focus = false;
        #layers_hog_keyboard_focus = true;
        disable_splash_rendering = true;
      };
      general = {
        # gaps_in = 5;
        # gaps_out = 5;
        # border_size = 2;
        # no_cursor_warps = true;
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 5;
        multisample_edges = true;
        # blur = {
        #   size = 8;
        #   passes = 3;
        #   new_optimizations = true;
        #   ignore_opacity = true;
        #   noise = "0.1";
        #   contrast = "0.9";
        #   brightness = "0.8";
        #   xray = true;
        # };
        # drop_shadow = true;
        # shadow_ignore_window = true;
        # shadow_offset = "0 8";
        # shadow_range = 50;
        # shadow_render_power = 3;
        "col.shadow" = "rgba(00000099)";
        blurls = [ "gtk-layer-shell" "waybar" "lockscreen" ];
      };
      animation = {
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      dwindle = {
        no_gaps_when_only = false;
        pseudotile = true;
        preserve_split = true;
      };
      master = { new_is_master = true; };

      "$VIDEODIR" = "$HOME/Videos";
      "$NOTIFY" =
        "notify-send -h string:x-canonical-private-synchronouse:hypr-cfg -u low";
      #"$SCREENSHOT" = "${homeDir}/.config/hypr/scripts/screensht";
      #"$COLORPICKER" = "${homeDir}/.config/hypr/scripts/colorpicker";

      bind = [
        "$MOD, Escape, exec, wlogout -p layer-shell"
        "$MOD, V, exec, wf-recorder -f $VIDEODIR/$(date +%Y-%m-%d_%H-%M-%S).mp4"
        "$MOD, V, exec, $NOTIFY 'Recording started'"
        "$MODSHIFT, V, exec, killall -s SIGINT wf-recorder"
        "$MODSHIFT, V, exec, $NOTIFY 'Recording stopped'"

        # ", Print, exec, $SCREENSHOT full"
        # "$MODSHIFT, S, exec, $SCREENSHOT area"
        # "$MODSHIFT, X, exec, $COLORPICKER"
        ",Print, exec, ags run-js 'ags.Service.Recorder.screenshot()'"
        # ", Print, exec, sleep 1 && grimblast --notify save area ~/Pictures/Screenshots/$(date +'%s_screenshot.png') &"

        "CTRL SHIFT, R, exec, pkill ags ; ags"
        "SUPER, D, exec, ags toggle-window overview"
        ", XF86PowerOff, exec, ags toggle-window powermenu"
        "SUPER, SPACE, exec, ags toggle-window applauncher"
        ", XF86Launch4, exec, ags run-js 'ags.Service.Recorder.start()'"

        "SUPER, Return, exec, kitty"
        "SUPER, W, exec, brave"
        "SUPER, E, exec, thunar"
        "SUPER, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "ALT, G, exec, rofi -modi emoji -show emoji"
        "ALT, W, exec, ~/.config/swww/changeWalls"
        "ALT, L, exec, swaylock"
        "ALT, SPACE, exec, pkill rofi || ~/.config/rofi/launchers/type-6/launcher.sh" 


        "CTRL ALT, Delete, exit"
        "SUPER, Q, killactive"
        "SUPER, F, togglefloating"
        "SUPER, G, fullscreen"
        "SUPER, O, fakefullscreen"
        "SUPER, P, togglesplit"
        #"$MOD, P, pseudo"
        "$MOD, S, togglesplit"

        "$MODSHIFT, Space, workspaceopt, allfloat"
        "$MODSHIFT, Space, exec, $NOTIFY 'Toggled All floating'"
        "$MODSHIFT, P, workspaceopt, allpseudotile"
        "$MODSHIFT, P, exec, $NOTIFY ' Toggled All pseudotile'"

        "$MOD, Tab, cyclenext"
        "$MOD, Tab, bringactivetotop"

        "$MOD, A, togglespecialworkspace"
        "$MOD, A, exec, $NOTIFY 'Toggled special workspace'"
        "$MODSHIFT, A, movetoworkspace, special"
        "$MOD, C, exec, hyprctl dispatch centerwindow"

        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER, l, movefocus, r"
        "SUPER, h, movefocus, l"

        "SUPER, left,  workspace, e-1"
        "SUPER, right, workspace, e+1"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER SHIFT, right, movetoworkspace, e+1"
        "SUPER SHIFT, left,  movetoworkspace, e-1"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        
        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
      ];
      binde = [
        "SUPER CTRL, k, resizeactive, 0 -20"
        "SUPER CTRL, j, resizeactive, 0 20"
        "SUPER CTRL, l, resizeactive, 20 0"
        "SUPER CTRL, h, resizeactive, -20 0"
        "SUPER ALT,  k, moveactive, 0 -20"
        "SUPER ALT,  j, moveactive, 0 20"
        "SUPER ALT,  l, moveactive, 20 0"
        "SUPER ALT,  h, moveactive, -20 0"
      ];
      bindm = [ "$MOD, mouse:272, movewindow" "$MOD, mouse:273, resizewindow" ];
      windowrulev2 = [
        "opacity 0.90 0.90,class:^(org.wezfurlong.wezterm)$"
        "opacity 0.90 0.90,class:^(Brave-browser)$"
        "opacity 0.90 0.90,class:^(brave-browser)$"
        "opacity 0.80 0.80,class:^(Steam)$"
        "opacity 0.80 0.80,class:^(steam)$"
        "opacity 0.80 0.80,class:^(steamwebhelper)$"
        "opacity 0.80 0.80,class:^(Spotify)$"
        "opacity 0.80 0.80,class:^(Code)$"
        "opacity 0.80 0.80,class:^(thunar)$"
        "opacity 0.80 0.80,class:^(file-roller)$"
        "opacity 0.80 0.80,class:^(nwg-look)$"
        "opacity 0.80 0.80,class:^(qt5ct)$"
        "opacity 0.80 0.80,class:^(discord)$"
        "opacity 0.80 0.80,class:^(WebCord)$"
        "opacity 0.80 0.70,class:^(pavucontrol)$"
        "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 0.80 0.80,class:^(org.telegram.desktop)$"
        "opacity 0.80 0.80,class:^(code-url-handler)$"
        "opacity 0.80 0.80,title:^(Spotify)$"

        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(pavucontrol)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Picture-in-Picture)$"
        "float,class:^(Viewnior)$"
        "float,title:^(DevTools)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float, ^(Rofi)$"
        "float, ^(org.gnome.Calculator)$"
        "float, ^(thunar)$"
        "float, ^(eww)$"
        "float, ^(pavucontrol)$"
        "float, ^(nm-connection-editor)$"
        "float, ^(blueberry.py)$"
        "float, ^(org.gnome.Settings)$"
        "float, ^(org.gnome.design.Palette)$"
        "float, ^(Color Picker)$"
        "float, ^(Network)$"
        "float, ^(xdg-desktop-portal)$"
        "float, ^(xdg-desktop-portal-gnome)$"
        "float, ^(transmission-gtk)$"
        "float, ^(ags)$"

        "noshadow, floating:0"

        "tile, title:^(Spotify)$"
        "workspace 9 silent, title:^(Spotify)$"
        "workspace 3, title:^(.*(Disc|WebC)ord.*)$"

        "idleinhibit focus, class:^(mpv|.+exe)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit fullscreen,class:^(Brave-browser)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];
      layerrule = [
        "blur, ^(gtk-layer-shell|anyrun)$"
        "ignorezero, ^(gtk-layer-shell|anyrun)$"
      ];
    };
  };
}
