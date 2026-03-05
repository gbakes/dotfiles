return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function()
      require("fzf-lua").setup({})

      local fzf = require("fzf-lua")
      local k = vim.keymap.set

      k("n", "<leader>ff", fzf.files, { desc = "Find Files" })
      k("n", "<leader>fc", function()
        fzf.files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find Config File" })
      k("n", "<leader>fs", fzf.live_grep, { desc = "Live Grep" })
      k("n", "<leader>fw", fzf.grep_cword, { desc = "Grep Word" })
      k("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
      k("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })
      k("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
      k("n", "<leader>fx", fzf.diagnostics_document, { desc = "Document Diagnostics" })
      k("n", "<leader>fX", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
    end,
  },
}
