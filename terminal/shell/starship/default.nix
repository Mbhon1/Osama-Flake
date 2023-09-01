{ pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
      "$directory" 
      "$git_branch" 
      "$character"
      "$os"
      "$nix_shell"
      ];
      right_format = "$git_status$cmd_duration$time";
      git_branch = {
        style = "bg:none fg:#8EC07C";
        format = "[]($style)[[ ](bg:#8EC07C fg:#312C2E bold)$branch](bg:#8EC07C fg:#312C2E)[ ]($style)";
      };
      directory = {
        style = "bg:none fg:#fe8019";
        truncation_length = 3;
        truncate_to_repo = false;
        format = "[]($style)[ ](bg:#fe8019 fg:#312C2E)[$path](bg:#fe8019 fg:#312C2E bold)[ ]($style)";
      };
     directory.substitutions = {
        "Documents" = " ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
        "Videos" = " ";
        "My Projects" = "󱌢 ";
        "Obsidian" = "󰑴 ";
        "GitHub" = "";
        ".config" = " ";
      }; 
      character = {
        success_symbol = "[](#8EC07C bold)";
        error_symbol = "[](#AD685A)";
        vicmd_symbol = "[](#DD8F6E)";
      };
      line_break = {
        disabled = true;
      };
      # git_status = {
      #   format = "[]($style)[$all_status$ahead_behind](bg:#689d6a fg:#312C2E)[ ]($style)";
      #   style = "bg:none fg:#689d6a";
      #   conflicted = "=";
      #   ahead =	"⇡${count}";
      #   behind = "⇣${count}";
      #   diverged = "⇕⇡ ${count}⇣";
      #   up_to_date = "";
      #   untracked = "?${count}";
      #   stashed = "";
      #   modified = "!${count}";
      #   staged = "+${count}";
      #   renamed = "»";
      #   deleted = "${count}";
      # };
      os = {
        disabled = false;
        # format = "[](fg:blue)[$symbol](bg:blue fg:black)[](fg:blue)";
        format = "$symbol";
      };
      os.symbols = {
        Arch = "[ ](fg:bright-blue)";
        Debian = "[ ](fg:red)";
        EndeavourOS = "[ ](fg:purple)";
        Fedora = "[ ](fg:blue)";
        NixOS = "[ ](fg:bright-white)";
        openSUSE = "[ ](fg:green)";
        SUSE = "[ ](fg:green)";
        Ubuntu = "[ ](fg:bright-purple)";
      };
      nix_shell = {
        disabled = false;
        format = "[](fg:white)[ ](bg:white fg:black)[](fg:white) ";
      };
      cmd_duration = {
        min_time = 1000;
        format = "[]($style)[[神](bg:#928374 fg:#312C2E bold)$duration](bg:#928374 fg:#312C2E)[ ]($style)";
        disabled = false;
        style = "bg:none fg:#928374";
      };
      time = {
        disabled = false;
        time_format = "%R"; # hour:minute format
        style = "bg:none fg:#d79923";
        format = "[]($style)[[ ](bg:#d79923 fg:#312C2E bold)$time](bg:#d79923 fg:#312C2E)[ ]($style)";
      };
      status = {
        symbol = "✗";
        not_found_symbol = "󰍉 Not Found";
        not_executable_symbol = " Can't Execute E";
        sigint_symbol = "󰂭 ";
        signal_symbol = "󱑽 ";
        success_symbol = "";
        format = "[$symbol](fg:red)";
        map_symbol = true;
        disabled = false;
      };
    };
   };
}
