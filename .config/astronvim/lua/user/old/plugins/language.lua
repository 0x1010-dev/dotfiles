return {
	"AstroNvim/astrolsp",
	optional = true,
	opts = {
		config = {
			volar = {
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			},
		},
	},
	-- syntax
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = {
				"bash",
				"dockerfile",
				"html",
				"css",
				"json",
				"jsonc",
				"lua",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"toml",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"vue",
				"yaml",
			}
		end,
	},
	-- language servers
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = {
				"bashls",
				"docker_compose_language_service",
				"dockerls",
				"html",
				"cssls",
				"jsonls",
				"lua_ls",
				"marksman",
				"pyright",
				"tsserver",
				"volar",
				"yamlls",
			}
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = {
				"typescript-language-server",
				"prettierd",
				"vue-language-server",
				"pyright",
				"black",
				"isort",
			}
		end,
	},
	-- formatters
	{
		"jay-babu/mason-null-ls.nvim",
		opts = function(_, opts)
			opts.ensure_installed = {
				"shellcheck",
				"shellfmt",
				"stylua",
				"prettierd",
				"black",
				"isort",
			}
		end,
	},
	-- debuggers
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			opts.ensure_installed = {
				"bash",
				"js",
			}
		end,
	},
	-- extras
	{
		"vuki656/package-info.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		event = "BufRead package.json",
	},
}
