return {
	"AstroNvim/astrocommunity",
	-- Color Schemes
	{ import = "astrocommunity.colorscheme.catppuccin", enabled = false },
	{ import = "astrocommunity.colorscheme.kanagawa-nvim", enabled = false },
	-- Bars & Lines
	-- { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
	-- { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
	{ import = "astrocommunity.bars-and-lines.vim-illuminate" },
	-- Code Runner
	{ import = "astrocommunity.code-runner.sniprun", enabled = false },
	-- Diagnostics
	{ import = "astrocommunity.diagnostics.lsp_lines-nvim", enabled = true },
	-- Editing Support
	{ import = "astrocommunity.editing-support.cutlass-nvim" },
	{ import = "astrocommunity.editing-support.multicursors-nvim" },
	{ import = "astrocommunity.editing-support.suda-vim" },
	{ import = "astrocommunity.editing-support.todo-comments-nvim" },
	{ import = "astrocommunity.editing-support.vim-move" },
	{ import = "astrocommunity.editing-support.wildfire-nvim" },
	-- Motion
	{ import = "astrocommunity.motion.mini-surround" },
	-- Utility
	{ import = "astrocommunity.utility.noice-nvim" },
	-- Configuration
	{
		"catppuccin",
		opts = {
			transparent_background = true,
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
	{
		"mason.nvim",
		opts = function(_, opts)
			opts.PATH = "append"
		end,
	},
	{
		"sniprun",
		opts = {
			display = { "TerminalWithCode" },
			selected_interpreters = {
				"Python3_fifo",
			},
			repl_enable = {
				"Python3_fifo",
			},
		},
	},
	{
		"cutlass.nvim",
		opts = {
			cut_key = "m",
		},
	},
}
