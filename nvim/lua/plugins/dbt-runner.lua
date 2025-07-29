return {
  -- dbt model runner for nvim
  -- Run dbt models directly from nvim with <leader>dr
  {
    "dbt-runner",
    dir = ".", -- Local plugin
    config = function()
      local M = {}

      -- Configuration
      local DBT_PROJECT_PATH =
        "/Users/georgebaker/Documents/Work/repo/geoguessr-dw/dagster/dagster_project/assets/geoguessr_dagster_dbt"

      function M.run_dbt_model()
        local filename = vim.fn.expand("%:t:r") -- Get filename without extension

        -- Check if we're in a .sql file
        if vim.fn.expand("%:e") ~= "sql" then
          vim.notify("Not a SQL file", vim.log.levels.WARN)
          return
        end

        -- Build the command with pyenv activation
        local cmd = string.format(
          'cd %s && eval "$(pyenv init -)" && pyenv activate geoguessr-dw && echo "Running dbt model: %s" && dbt run --select %s && echo "\\n--- Sample Results (first 20 rows) ---" && dbt show --select %s --limit 20',
          DBT_PROJECT_PATH,
          filename,
          filename,
          filename
        )

        -- Create horizontal split and run command in terminal
        vim.cmd("split")
        vim.cmd("resize 15") -- Make it smaller initially
        vim.cmd("terminal " .. cmd)

        -- Enter insert mode in terminal
        vim.cmd("startinsert")
      end

      -- Set up the keybinding
      vim.keymap.set("n", "<leader>dr", M.run_dbt_model, {
        desc = "Run dbt model from current file",
        noremap = true,
        silent = true,
      })

      return M
    end,
  },
}

