-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      autopairs = true,
      cmp = true,
    },
    diagnostics = {
      update_in_insert = false,
      virtual_lines = {
        only_current_line = true,
      },
    },
    autocmds = {
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session",
          nested = true,
          callback = function()
            -- only load session if nvim started with no args
            if vim.fn.argc(-1) == 0 then
              require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
          end,
        },
      },
    },
    filetypes = {
      extension = {
        qml = "qmljs",
      },
    },
    options = {
      o = {
        scrolloff = 15,
      },
    },
    mappings = {
      n = {
        -- better buffer navigation
        ["]b"] = false,
        ["[b"] = false,
        ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Prev buffer" },
        -- better increment/decrement
        ["-"] = { "<C-x>", desc = "Decrement number" },
        ["+"] = { "<C-a>", desc = "Increment number" },
      },
      t = {
        ["<Esc><Esc>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
      },
      x = {
        ["<C-S>"] = false,
        -- better increment/decrement
        ["+"] = { "g<C-a>", desc = "Increment number" },
        ["-"] = { "g<C-x>", desc = "Decrement number" },
      },
    },
  },
}
