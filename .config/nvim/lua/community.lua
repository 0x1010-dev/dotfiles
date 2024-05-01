-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Color Scheme
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  -- Bars & Lines
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  -- Split & Window
  { import = "astrocommunity.split-and-window.mini-map" },
  -- Language Packs
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.typescript" },
  -- Diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- Editing Support
  { import = "astrocommunity.editing-support.cutlass-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.editing-support.suda-vim" },
  -- Motion
  { import = "astrocommunity.motion.mini-surround" },
  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },
  -- Configuration
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        dim_inactive = true,
      },
    },
  },
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "m",
    },
  },
  {
    "okuuva/auto-save.nvim",
    opts = {
      debounce_delay = 3000,
      execution_message = {
        enabled = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = { enabled = true },
        hover = { enabled = false },
        signature = { enabled = true },
      },
      routes = {
        { filter = { event = "msg_show", cmdline = "^:lua" }, view = "messages" }, -- send lua output to split
        { filter = { event = "msg_show", min_height = 20 }, view = "messages" }, -- send long messages to split
        { filter = { event = "msg_show", find = "%d+L,%s%d+B" }, opts = { skip = true } }, -- skip save notifications
        { filter = { event = "msg_show", find = "^%d+ more lines$" }, opts = { skip = true } }, -- skip paste notifications
        { filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
        { filter = { event = "msg_show", find = "^%d+ lines yanked$" }, opts = { skip = true } }, -- skip yank notifications
      },
    },
  },
}
