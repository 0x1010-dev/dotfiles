return {
	"AstroNvim/astrocommunity",
	-- Color Schemes
	{ import = "astrocommunity.colorscheme.catppuccin",               enabled = true },
	{ import = "astrocommunity.colorscheme.kanagawa-nvim",            enabled = false },
	-- Bars & Lines
	-- { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
	{ import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
	{ import = "astrocommunity.bars-and-lines.vim-illuminate" },
	-- Diagnostics
	{ import = "astrocommunity.diagnostics.lsp_lines-nvim" },
	-- Editing Support
	{ import = "astrocommunity.editing-support.cutlass-nvim" },
	{ import = "astrocommunity.editing-support.multicursors-nvim" },
	{ import = "astrocommunity.editing-support.suda-vim" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.editing-support.vim-move" },
	{ import = "astrocommunity.editing-support.wildfire-nvim" },
	-- Motion
	{ import = "astrocommunity.motion.mini-surround" },
	-- Language Packs
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.vue" },
	{ import = "astrocommunity.pack.yaml" },
	-- Configuration
	{
		"catppuccin",
		opts = {
			transparent_background = false,
			dim_inactive = { enabled = true, percentage = 0.40 },
		},
	},
	{
		"kanagawa.nvim",
		opts = {
			flavour = "mocha",
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	},
	{
		"lsp_lines.nvim",
		opts = {
			only_current_line = true,
		},
	},
}
