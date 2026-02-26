return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "\u{2590}" },
          change = { text = "\u{2590}" },
          delete = { text = "\u{2590}" },
          topdelete = { text = "\u{25e6}" },
          changedelete = { text = "\u{25cf}" },
          untracked = { text = "\u{25cb}" },
        },
        signcolumn = true,
        current_line_blame = false,
      })

      local k = vim.keymap.set
      local gs = require("gitsigns")

      k("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
      k("n", "[h", gs.prev_hunk, { desc = "Prev git hunk" })
      k("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
      k("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      k("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame line" })
      k("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
      k("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
    end,
  },
}
