{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.vls
    nodePackages.vercel
    nodePackages.pnpm 
    lua-language-server
    nodePackages_latest.typescript
    nodePackages_latest.eslint
    rust-analyzer
    xclip
    cliphist
  ];

  programs.neovim = 
  # let
  #   toLua = str: "lua << EOF\n${str}\nEOF\n";
  #   toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  # in
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
    # plugins = with pkgs.vimPlugins; [
    # { 
    #   plugin = comment-nvim;
    #   config = toLuaFile ./neovim/lua/plugins/comment.lua;
    # }
    # {
    #   plugin = gruvbox-nvim;
    #   config = "colorscheme gruvbox";
    # }
    # neodev-nvim
    # vim-nix
    # nvim-cmp
    # {
    #   plugin = alpha-nvim;
    #   config = toLuaFile ./neovim/lua/plugins/alpha.lua;
    # }
    # telescope-nvim
    # telescope-fzf-native-nvim
    # cmp_luasnip
    # cmp-nvim-lsp
    # luasnip
    # friendly-snippets
    # nvim-autopairs
    # bufferline-nvim
    # scope-nvim
    # null-ls-nvim
    # #mason-null-ls-nvim
    # typescript-nvim
    # which-key-nvim
    # lualine-nvim
    # nvim-web-devicons
    # (nvim-treesitter.withPlugins (p: [
    #   p.tree-sitter-nix
    #   p.tree-sitter-vim
    #   p.tree-sitter-bash
    #   p.tree-sitter-lua
    #   p.tree-sitter-json
    #   p.tree-sitter-python
    #   ]))
    # ];
    # extraLuaConfig = ''
    #   -- lua code here
    #   
    #   -- interpolate files like this:
    #   ${builtins.readFile ./neovim/init.lua}
    #   
    #   ${builtins.readFile ./neovim/lua/core/init.lua}
    #   ${builtins.readFile ./neovim/lua/core/options.lua}
    #   ${builtins.readFile ./neovim/lua/core/utils.lua}
    #   ${builtins.readFile ./neovim/lua/core/keymaps.lua}
    #   ${builtins.readFile ./neovim/lua/core/autocommands.lua}


    #   ${builtins.readFile ./neovim/ftplugin/java.lua}
    #   ${builtins.readFile ./neovim/stylua.toml}

    #   ${builtins.readFile ./neovim/snippets/vscode/cpp.json}
    #   ${builtins.readFile ./neovim/snippets/vscode/package.json}
    #   ${builtins.readFile ./neovim/snippets/snipmate/cpp.snippets}

    #   ${builtins.readFile ./neovim/lua/plugins/alpha.lua}

    #   '';
  };

  home.file.".config/nvim" = {
    source = ./neovim;
  };
}
