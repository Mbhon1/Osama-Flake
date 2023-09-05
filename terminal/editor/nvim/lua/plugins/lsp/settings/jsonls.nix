{
  home.file.".config/nvim/lua/plugins/lsp/settings/jsonls.lua".text = ''
    return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
    '';

}
