return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({})

      local ensure_installed = {
        "vim", "vimdoc", "lua", "python", "bash",
        "sql", "yaml", "json", "markdown", "html", "css",
        "javascript", "typescript",
      }

      local ts_config = require("nvim-treesitter.config")
      local already_installed = ts_config.get_installed()
      local to_install = {}
      for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(already_installed, parser) then
          table.insert(to_install, parser)
        end
      end
      if #to_install > 0 then
        treesitter.install(to_install)
      end

      local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and vim.list_contains(treesitter.get_installed(), lang) then
            vim.treesitter.start(args.buf)
          end
        end,
      })
    end,
  },
}
