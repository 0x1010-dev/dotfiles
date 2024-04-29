-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@type AstroLSPOpts
  opts = {
    autocmds = {
      eslint_fix_on_save = false,
    },
    on_attach = function(client, _)
      -- disable formatter for volar
      if client.name == "volar" then client.server_capabilities.documentFormattingProvider = false end
    end,
  },
}
