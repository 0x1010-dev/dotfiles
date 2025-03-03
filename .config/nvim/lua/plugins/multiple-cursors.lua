return {
  "brenton-leighton/multiple-cursors.nvim",
  cmd = {
    "MultipleCursorsAddDown",
    "MultipleCursorsAddUp",
    "MultipleCursorsMouseAddDelete",
    "MultipleCursorsAddMatches",
    "MultipleCursorsAddMatchesV",
    "MultipleCursorsAddJumpNextMatch",
    "MultipleCursorsJumpNextMatch",
    "MultipleCursorsLock",
  },
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      for lhs, map in pairs {
        ["<C-Up>"] = { "<Cmd>MultipleCursorsAddUp<CR>", desc = "Add cursor up" },
        ["<C-Down>"] = { "<Cmd>MultipleCursorsAddDown<CR>", desc = "Add cursor down" },
        ["<C-LeftMouse>"] = { "<Cmd>MultipleCursorsMouseAddDelete<CR>", desc = "Add cursor with mouse" },
      } do
        maps.n[lhs] = map
        maps.i[lhs] = map
      end
      local prefix = "<Leader>m"
      for lhs, map in pairs {
        [prefix] = { desc = " Multiple Cursors" },
        [prefix .. "a"] = { "<Cmd>MultipleCursorsAddMatches<CR>", desc = "Add cursor matches" },
        [prefix .. "A"] = { "<Cmd>MultipleCursorsAddMatchesV<CR>", desc = "Add cursor matches in previous visual area" },
        [prefix .. "j"] = { "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", desc = "Add cursor and jump to next match" },
        [prefix .. "J"] = { "<Cmd>MultipleCursorsJumpNextMatch<CR>", desc = "Move cursor to next match" },
        [prefix .. "l"] = { "<Cmd>MultipleCursorsLock<CR>", desc = "Lock virtual cursors" },
      } do
        maps.n[lhs] = map
        maps.x[lhs] = map
      end
    end,
  },
  opts = {
    custom_key_maps = {
      {
        "n",
        "<Leader>mz",
        function(_, count, motion_cmd, char) vim.cmd("normal " .. count .. "gza" .. motion_cmd .. char) end,
        "mc",
        desc = "Surround",
      },
    },
  },
}
