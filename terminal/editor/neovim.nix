{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.vls
    nodePackages.vercel
    lua-language-server
    nodePackages_latest.typescript
    nodePackages_latest.eslint
    rust-analyzer
    xclip
    cliphist
  ];

  programs.neovim = 
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      luajitPackages.lua-lsp
      rnix-lsp
      alejandra
      statix
      nil
    ];
  };

  home.file.".config/nvim" = {
    source = ./neovim;
  };
}
