return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        enabled = true,
        -- Show jump labels when using f/F/t/T
        jump_labels = true,
        -- Multi-line f/F/t/T
        multi_line = true,
        -- Show labels after auto-jump
        label = { after = { 0, 0 } },
        -- Highlight the matches
        highlight = { backdrop = false },
        -- Keys to use for jump labels
        keys = { "f", "F", "t", "T", ";", "," },
      },
    },
  },
  
  config = function(_, opts)
    require("flash").setup(opts)
    
    -- Custom highlight colors for f/F/t/T motions
    vim.api.nvim_set_hl(0, "FlashMatch", { 
      bg = "#ff9e64", -- Orange background
      fg = "#1a1b26", -- Dark text
      bold = true 
    })
    
    vim.api.nvim_set_hl(0, "FlashLabel", { 
      bg = "#9ece6a", -- Green background
      fg = "#1a1b26", -- Dark text
      bold = true,
      underline = true
    })
    
    vim.api.nvim_set_hl(0, "FlashCurrent", { 
      bg = "#7aa2f7", -- Blue background  
      fg = "#1a1b26", -- Dark text
      bold = true 
    })
  end,
}