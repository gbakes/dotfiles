return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local k = vim.keymap.set

      k("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Harpoon: add file" })
      k("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: menu" })
      k("n", "<leader>hn", function()
        harpoon:list():next()
      end, { desc = "Harpoon: next" })
      k("n", "<leader>hp", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: prev" })
    end,
  },
}
