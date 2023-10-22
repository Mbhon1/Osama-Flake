{ config, lib, ... }: 
{
  xdg.configFile."/home/luis/.zshrc".text = ''
    export VISUAL='nvim'
      export EDITOR='nvim'
      export TERMINAL='kitty'
      export GPG_TTY=$(tty)
      export BROWSER='brave-browser'
      export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
      export PATH=$PATH:~/.local/bin/
      export PATH=/tmp/lazy-lvim/bin:$PATH
      export PATH="$PATH:/home/luis/.nix-profile/bin/elixir"
      export PATH="$PATH:/home/luis/.nix-profile/bin/swww"
      export PATH="$PATH:/home/luis/.nix-profile/bin/swww-daemon"
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
      setopt LIST_PACKED		     # The completion menu takes less space.
      setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
      setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
      setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
      setopt COMPLETE_IN_WORD    # Complete from both ends of a word.


      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      $HOME/.local/bin/colorscript -r
      source ~/.config/zsh/nvim
      source $HOME/zsh-you-should-use/zsh-you-should-use.plugin.zsh

      # Android studio env for react native
      export ANDROID_HOME=$HOME/Android/Sdk
      export PATH=$PATH:$ANDROID_HOME/emulator
      export PATH=$PATH:$ANDROID_HOME/platform-tools
    '';
}
