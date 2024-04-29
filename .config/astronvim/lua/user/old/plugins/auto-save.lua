return {
	"okuuva/auto-save.nvim",
	lazy = false,
	opts = {
		enabled = true,
		write_all_buffers = false,
		debounce_delay = 5000,
		execution_message = {
			enabled = false,
		},
		trigger_events = {
			immediate_save = { "BufLeave" },
			-- defer_save = { "InsertLeave" },
			-- cancel_defered_save = { "InsertEnter" },
		},
	},
}
