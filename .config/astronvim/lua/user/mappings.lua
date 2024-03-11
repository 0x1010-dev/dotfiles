local astro_utils = require "astronvim.utils"
local mappings = {
  n = {
    -- write as sudo
    ["<leader>W"] = { ":SudaWrite<cr>", desc = "Sudo Write" },
    -- tmux vim navigator
    -- ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", desc = "Window Left" },
    -- ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", desc = "Window Right" },
    -- ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", desc = "Window Down" },
    -- ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", desc = "Window Up" },
    -- buffer switching
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers {
            sort_mru = true,
            ignore_current_buffer = true
          }
        else
          astro_utils.notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers"
    },
    -- better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next Buffer"
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous Buffer"
    },
    -- better increment/decrement
    ["-"] = { "<c-x>", desc = "Decrement Number" },
    ["+"] = { "<c-a>", desc = "Increment Number" },
    -- resize with arrows
    ["<Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
    ["<Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
    ["<Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
    ["<Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
  },
}

return mappings
