{ pkgs, ...}:
{
  home.packages = with pkgs; [ git ];
  programs.git = {
    enable = true;
    userName = "Mbhon1";
    userEmail = "mbhoni@proton.me";
    signing = {
      key = "F03540E63DA3CB9B48BE3B71572B89161DD1FB0B";
      signByDefault = true;
    };

    aliases = {
      st = "status";
      p = "pull";
      c = "commit";
      cm = "commit -m";
      co = "checkout";
    };
    ignores = [".elixir-ls" ".envrc" ".vim" "node_modules"];
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        side-by-side = true;
        line-numbers = true;
      };
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = { editor = "nvim"; };
      diff = { algorithm = "histogram"; };
      status = { showUntrackedFiles = "all"; };
      blame = { date = "relative"; };
      rebase = { autosquash = true; };
      merge = { conflictStyle = "diff3"; };
      pull = { ff = "only"; };
      commit = { 
        verbose = true;
        gpgsign = true;
      };
    };
  };

}
