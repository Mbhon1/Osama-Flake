{
  home.file.".config/nvim/lua/plugins/autopairs.lua".text = ''
    return {
  -- Autocomplete brackets
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {
      disable_filetype = { "TelescopePrompt", "vim" },
    }
  end,
}
    '';
}
