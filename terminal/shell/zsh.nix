{pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    ripgrep
    fzf
    ranger
    lazygit
    tmux
    tmux-mem-cpu-load
  ];

  # home.file = {
  #   ".local/share/zsh/zsh-autosuggestions".source = 
  #     "${pkgs.zsh-autosuggestions}/share/zsh/zsh-autosuggestions";
  #   ".local/share/zsh/zsh-history-substring-search".source = 
  #     "${pkgs.zsh-history-substring-search}/share/zsh/zsh-history-substring-search";
  #   ".local/share/zsh/zsh-syntax-highlighting".source = 
  #     "${pkgs.zsh-syntax-highlighting}/share/zsh/zsh-syntax-highlighting";
  #   ".local/share/zsh/zsh-you-should-use".source =
  #     "${pkgs.zsh-you-should-use}/share/zsh";
  #   ".local/share/zsh/nix-zsh-completions".source = 
  #     "${pkgs.nix-zsh-completions}/share/zsh/plugings/nix";
  #   ".local/share/zsh/zsh-history".source = 
  #     "${pkgs.zsh-history}/share/zsh/plugins";
  # };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        # "zsh-you-should-use"
        "git"
        "colorize"
        "colored-man-pages"
        "command-not-found"
        "history-substring-search"
      ];
    };
    plugins = with pkgs; [
      {
        name = "forgit"; # i forgit :skull:
        file = "forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "99cda3248c205ba3c4638c4e461afce01a2f8acb";
          sha256 = "0jd0nl0nf7a5l5p36xnvcsj7bqgk0al2h7rdzr0m1ldbd47mxdfa";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "13d7b4e63468307b6dcb2dadf6150818f242cbff";
          sha256 = "0ghzqg1xfvqh9z23aga7aafrpxbp9bpy1r8vk4avi6b80p3iwsq2";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
          sha256 = "0lfl4r44ci0wflfzlzzxncrb3frnwzghll8p365ypfl0n04bkxvl";
        };
      }
    ];
    cdpath = ["." "/home/mbhon1" "/home/mbhon1/Pictures"];
    dotDir = ".config/zsh";
    shellAliases = {
      cat = "bat --paging=never";
      mv = "mv -iv";
      cp = "cp -iv";
      rm = "rm -v";
      vi = "nvim";
      ni = "npm install";
      next = "npx create-next-app@latest";
      lazy = "lazygit";
      nrd = "npm run dev";
      kt = "kitty +kitten themes";
      icat = "kitty +kitten icat";
      mdc = "mdcat";
      ccd = "chezmoi cd";
      cca = "chezmoi add";
      tms = "tmux new -s";
      tmls = "tmux ls";
      tmd = "tmux detach";
      tma = "tmux attach -t";
      installed =
        "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq ";
      installedall = "nix-store --query --requisites /run/current-system ";
      cleanup = "sudo nix-collect-garbage --delete-older-than 1d";
      listgen =
        "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      forceclean = "sudo nix-collect-garbage -d";
      nixremove = "nix-store --gc";
      cleanram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
      hmg = "home-manager generations";
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      expireDuplicatesFirst = true;
      ignoreDups = true;
      extended = true;
      ignoreSpace = true;
    };
  };

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

  xdg.configFile."/home/mbhon1/.zshrc".text = ''
    export VISUAL='nvim'
      export EDITOR='nvim'
      export TERMINAL='kitty'
      export GPG_TTY=$(tty)
      export BROWSER='brave-browser'
      export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
      export PATH=$PATH:~/.local/bin/
      export PATH=/tmp/lazy-lvim/bin:$PATH
      export PATH="$PATH:/home/mbhon1/.nix-profile/bin/elixir"
      export PATH="$PATH:/home/mbhon1/.nix-profile/bin/swww"
      export PATH="$PATH:/home/mbhon1/.nix-profile/bin/swww-daemon"
      export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/74e2faf5965a12e8fa5cff799b1b19c6cd26b0e3.tar.gz
      
      autoload -Uz compinit

      for dump in ~/.config/zsh/zcompdump(N.mh+24); do
        compinit -d ~/.config/zsh/zcompdump
      done

      compinit -C -d ~/.config/zsh/zcompdump

      autoload -Uz add-zsh-hook
      autoload -Uz vcs_info
      precmd () { vcs_info }
      _comp_options+=(globdots)

      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      zstyle ":completion:*" verbose true
      zstyle ":completion:*:*:*:*:*" menu select
      zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
      zstyle ":completion:*:warnings" format "%B%F{red}No matches for:%f %F{magenta}%d%b"
      zstyle ":completion:*:descriptions" format "%F{yellow}[-- %d --]%f"
      zstyle ":vcs_info:*" formats " %B%s-[%F{magenta}%f %F{yellow}%b%f]-"

      HISTFILE=~/.config/zsh/zhistory
      HISTSIZE=5000
      SAVEHIST=5000

      setopt AUTOCD              # change directory just by typing its name
      setopt PROMPT_SUBST        # enable command substitution in prompt
      setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
      setopt LIST_PACKED		   # The completion menu takes less space.
      setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
      setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
      setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
      setopt COMPLETE_IN_WORD    # Complete from both ends of a word.


      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      $HOME/.local/bin/colorscript -r
      source ~/.config/zsh/nvim

      # Android stuido env for react native
      export ANDROID_HOME=$HOME/Android/Sdk
      export PATH=$PATH:$ANDROID_HOME/emulator
      export PATH=$PATH:$ANDROID_HOME/platform-tools
    '';
  
}
