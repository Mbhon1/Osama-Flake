{pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    ripgrep
    fzf
    ranger
    lazygit
    tmux
    tmux-mem-cpu-load
    eza
  ];

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      theme_background = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colorize"
        "colored-man-pages"
        "command-not-found"
        "history-substring-search"
      ];
    };
    plugins = with pkgs; [
      {
        name = "forgit"; 
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
      {
        name = "zsh-you-should-use";
        file = "zsh-you-should-use.plugin.zsh";
        src = fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          sha256 = "1dz48rd66priqhxx7byndqhbmlwxi1nfw8ik25k0z5k7k754brgy";
          rev = "1f9cb008076d4f2011d5f814dfbcfbece94a99e0";
        };
      } 
    ];
    cdpath = ["." "/home/luis" "/home/luis/Pictures"];
    dotDir = ".config/zsh";
    shellAliases = {
      cat = "bat --paging=never";
      mv = "mv -iv";
      cls = "clear";
      e = "exit";
      cp = "cp -iv";
      rm = "rm -v";
      vi = "nvim";
      r = "ranger";
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
      nf = "neofetch";
      of = "onefetch";
      nrs = "sudo nixos-rebuild switch";
      hms = "home-manager switch";
      hmg = "home-manager generations";
      installed =
        "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq ";
      installedall = "nix-store --query --requisites /run/current-system ";
      cleanup = "sudo nix-collect-garbage --delete-older-than 2d";
      listgen =
        "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      forceclean = "sudo nix-collect-garbage -d";
      nixremove = "nix-store --gc";
      cleanram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
      sR = "wf-recorder --audio --file=/home/luis/Pictures/Screenshots/";
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      expireDuplicatesFirst = true;
      ignoreDups = true;
      extended = true;
      ignoreSpace = true;
    };
  };

}
