local utils = require("astronvim.utils")
local prefix = "<leader>r"
local icon = vim.g.icons_enabled and "> " or ""
utils.set_mappings({ n = { [prefix] = { desc = icon .. "Molten" } } })

return {
	"benlubas/molten-nvim",
	version = "^1.0.0",
	build = ":UpdateRemotePlugins",
	ft = "python",
	init = function()
		vim.g.molten_auto_open_html_in_browser = true
		vim.g.molten_output_virt_lines = true

		vim.api.nvim_create_autocmd("User", {
			pattern = "MoltenInitPre",
			callback = function()
				vim.b[0].autoformat_enabled = false
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MoltenDeinitPre",
			command = "MoltenSave",
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MoltenDeinitPost",
			callback = function()
				vim.b[0].autoformat_enabled = true
			end,
		})
	end,
	keys = {
		{
			prefix .. "i",
			":MoltenInit<CR>",
			desc = "Init Kernel",
		},
		{
			prefix .. "e",
			":MoltenLoad<CR>",
			desc = "Load Session",
		},
		{
			prefix .. "l",
			":MoltenEvaluateLine<CR>",
			desc = "Evaluate Line",
		},
		{
			prefix .. "o",
			":MoltenEvaluateOperation<CR>",
			desc = "Evaluate Operator",
		},
		{
			prefix .. "r",
			":MoltenReevaluateCell<CR>",
			desc = "Re-evaluate Cell",
		},
		{
			prefix .. "d",
			":MoltenDelete<CR>",
			desc = "Delete Cell",
		},
		{
			prefix .. "s",
			":noautocmd MoltenEnterOutput<CR>",
			desc = "Show Output",
		},
		{
			prefix .. "h",
			":MoltenHideOutput<CR>",
			desc = "Hide Output",
		},
		{
			prefix .. "x",
			":MoltenRestart<CR>",
			desc = "Restart Kernel",
		},
		{
			prefix .. "b",
			":MoltenOpenInBrowser<CR>",
			desc = "Open In Browser",
		},
		{
			prefix,
			":<C-u>MoltenEvaluateVisual<CR>gv",
			desc = icon .. "Molten: Evaluate Selection",
			mode = "v",
		},
	},
}
