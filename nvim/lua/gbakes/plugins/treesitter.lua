return {
	"nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			ensure_installed = {
				"json",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"python",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			sync_install = false,

			auto_install = true,

			ignore_install = {},

			highlight = {

				enable = true,

				disable = {},
			},
		})
	end,
}
