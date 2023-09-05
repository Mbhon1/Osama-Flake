{
  home.file.".config/nvim/lua/plugins/lsp/settings/lua_ls.lua".text = ''
    return {
  settings = {
    Lua = {
      semantic = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = { enable = false },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}
    '';

}
