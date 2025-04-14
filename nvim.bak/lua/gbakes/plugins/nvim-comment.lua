return {
	-- Option 1: nvim-comment
	{
		"terrortylor/nvim-comment",
		event = "VeryLazy",
		config = function()
			require("nvim_comment").setup({
				-- Lines to be ignored while comment/uncomment.
				-- Could be a regex string or a function that returns a regex string.
				-- Example: Use '^$' to ignore empty lines
				ignore = "^$",
				-- LHS of toggle mappings in NORMAL mode
				toggler = {
					-- Line-comment toggle keymap
					line = "gcc",
					-- Block-comment toggle keymap
					block = "gbc",
				},
				-- LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					-- Line-comment keymap
					line = "gc",
					-- Block-comment keymap
					block = "gb",
				},
				-- Enable keybindings
				-- NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					-- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					-- Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
			})
		end,
	},
}
