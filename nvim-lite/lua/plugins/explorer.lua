return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        filters = { dotfiles = false },
        renderer = { group_empty = true },
      })

      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })

      local toggle = function()
        require("nvim-tree.api").tree.toggle()
      end
      vim.keymap.set("n", "<leader>e", toggle, { desc = "Toggle NvimTree" })
      vim.keymap.set("n", "<leader>ee", toggle, { desc = "Toggle NvimTree" })
    end,
  },
}
