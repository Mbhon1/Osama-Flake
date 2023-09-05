{
  home.file.".config/nvim/lua/plugins/regexplainer.lua".text = ''
    return { 'bennypowers/nvim-regexplainer',
  config = function() 
    require'regexplainer'.setup{} 
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'MunifTanjim/nui.nvim',
  },
}
    '';
}
