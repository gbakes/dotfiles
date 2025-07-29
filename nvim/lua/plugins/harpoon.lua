return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon").setup({
			menu = {
				width = math.floor(vim.api.nvim_win_get_width(0) * 0.6),
				height = 12,
			},
		})

		-- Custom highlight groups for harpoon
		vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = "#282828", fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = "#fabd2f" })
	end,
}