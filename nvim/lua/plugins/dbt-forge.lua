return {
  {
    "gbakes/dbt-forge.nvim",
    url = "https://github.com/gbakes/dbt-forge.git",
    config = function()
      require("dbt-forge").setup({

        -- Auto-detects dbt_project_path, python_env_manager, and python_env_name
        -- Override only if needed:
        -- dbt_project_path = "/custom/path/to/dbt/project",
        -- python_env_manager = "pyenv", -- "pyenv", "conda", "venv", or "none"
        -- python_env_name = "my-env",
        keymaps = {
          run_model = "<leader>dr",
          transpile_model = "<leader>dt",
          test_model = "<leader>dT",
        },
      })
    end,
    ft = "sql", -- Only load for SQL files
  },
}
