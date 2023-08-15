{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.vls
    lua-language-server
    nodePackages_latest.typescript
    nodePackages_latest.eslint
    rust-analyzer
    xclip
    cliphist
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
    # plugins = with pkgs.vimPlugins; [
    # neoscroll-nvim
    # ];
  };

  home.file.".config/nvim" = {
    source = ./neovim;
  };
}
