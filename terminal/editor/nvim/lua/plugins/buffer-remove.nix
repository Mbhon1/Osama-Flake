{
  home.file.".config/nvim/lua/plugins/buff-remove.lua".text = ''
    return {
	"echasnovski/mini.bufremove",
  -- stylua: ignore
  keys = {
    { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  },
}
    '';
}
