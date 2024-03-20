local function get_real_path(symlink_path)
	local handle = io.popen("readlink -f " .. symlink_path)
	if handle then
		local results = handle:read("*a")
		handle:close()
		return results:gsub("%s+", "")
	else
		return symlink_path
	end
end

return {
	{
		"lewis6991/gitsigns.nvim",
		opts = function(_, opts)
			opts.sign_priority = 1
			opts.signcolumn = true
			opts.numhl = false
		end,
	},
	{
		"rebelot/heirline.nvim",
		opts = function(_, opts)
			local status = require("astronvim.utils.status")

			opts.statuscolumn = {
				status.component.foldcolumn(),
				status.component.fill(),
				status.component.signcolumn(),
				status.component.fill(),
				status.component.numbercolumn(),
			}

			return opts
		end,
	},
	{
		"folke/neodev.nvim",
		lazy = true,
		opts = {
			override = function(root_dir, library)
				for _, astronvim_config in ipairs(astronvim.supported_configs) do
					local path = get_real_path(astronvim_config)
					if root_dir:match(path) then
						library.plugins = true
						break
					end
				end
				vim.b.neodev_enabled = library.enabled
			end,
		},
	},
}
