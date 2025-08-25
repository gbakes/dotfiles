return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spectre").setup({
      color_devicons = true,
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete"
      },
      mapping = {
        ['run_current_replace'] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
        ['run_replace'] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all"
        },
        ['accept_current'] = {
          map = "<CR>",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "accept current change"
        },
        ['accept_all'] = {
          map = "<leader>a",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "accept all changes"
        },
      },
    })
  end,
}