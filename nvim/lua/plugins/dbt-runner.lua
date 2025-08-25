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

      function M.transpile_dbt_model()
        local filename = vim.fn.expand("%:t:r") -- Get filename without extension

        -- Check if we're in a .sql file
        if vim.fn.expand("%:e") ~= "sql" then
          vim.notify("Not a SQL file", vim.log.levels.WARN)
          return
        end

        vim.notify("Transpiling dbt model: " .. filename, vim.log.levels.INFO)

        -- Function to run command and capture output
        local function run_command(cmd)
          local handle = io.popen(cmd)
          if not handle then
            return nil, "Failed to execute command"
          end
          local result = handle:read("*a")
          local success = handle:close()
          return result, success
        end

        -- Build commands for both incremental and non-incremental
        local base_cmd = string.format(
          'cd %s && eval "$(pyenv init -)" && pyenv activate geoguessr-dw',
          DBT_PROJECT_PATH
        )
        
        local compile_cmd = base_cmd .. string.format(' && dbt compile --select %s', filename)
        local compile_full_refresh_cmd = base_cmd .. string.format(' && dbt compile --select %s --full-refresh', filename)

        -- Get compiled SQL paths
        local compiled_path = string.format("%s/target/compiled/*/*/models/*/%s.sql", DBT_PROJECT_PATH, filename)
        local find_compiled_cmd = string.format('find %s/target/compiled -name "%s.sql" -type f | head -1', DBT_PROJECT_PATH, filename)

        -- Run compilation
        local compile_result, compile_success = run_command(compile_cmd)
        if not compile_success then
          vim.notify("Failed to compile dbt model", vim.log.levels.ERROR)
          return
        end

        -- Find the compiled file
        local compiled_file_result, _ = run_command(find_compiled_cmd)
        if not compiled_file_result or compiled_file_result == "" then
          vim.notify("Could not find compiled SQL file", vim.log.levels.ERROR)
          return
        end
        
        local compiled_file_path = compiled_file_result:gsub("\n", "")

        -- Read the compiled SQL (incremental version)
        local incremental_sql = ""
        local file = io.open(compiled_file_path, "r")
        if file then
          incremental_sql = file:read("*a")
          file:close()
        else
          vim.notify("Could not read compiled SQL file", vim.log.levels.ERROR)
          return
        end

        -- Compile with full-refresh for non-incremental version
        local compile_full_result, compile_full_success = run_command(compile_full_refresh_cmd)
        local non_incremental_sql = ""
        
        if compile_full_success then
          local file_full = io.open(compiled_file_path, "r")
          if file_full then
            non_incremental_sql = file_full:read("*a")
            file_full:close()
          end
        end

        -- Create content for floating window
        local content = {}
        table.insert(content, "-- DBT MODEL: " .. filename)
        table.insert(content, "")
        table.insert(content, "-- =====================================")
        table.insert(content, "-- INCREMENTAL SQL")
        table.insert(content, "-- =====================================")
        table.insert(content, "")
        
        -- Add incremental SQL
        for line in incremental_sql:gmatch("[^\r\n]+") do
          table.insert(content, line)
        end
        
        table.insert(content, "")
        table.insert(content, "")
        table.insert(content, "-- =====================================")
        table.insert(content, "-- NON-INCREMENTAL SQL (FULL REFRESH)")
        table.insert(content, "-- =====================================")
        table.insert(content, "")
        
        -- Add non-incremental SQL
        if non_incremental_sql ~= "" and non_incremental_sql ~= incremental_sql then
          for line in non_incremental_sql:gmatch("[^\r\n]+") do
            table.insert(content, line)
          end
        else
          table.insert(content, "-- Same as incremental version")
        end

        -- Create floating window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
        vim.api.nvim_buf_set_option(buf, 'filetype', 'sql')
        vim.api.nvim_buf_set_option(buf, 'readonly', true)
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)

        -- Calculate window size
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local opts = {
          relative = 'editor',
          width = width,
          height = height,
          row = row,
          col = col,
          border = 'rounded',
          title = ' DBT Transpiled SQL: ' .. filename .. ' ',
          title_pos = 'center'
        }

        local win = vim.api.nvim_open_win(buf, true, opts)
        
        -- Set window options
        vim.api.nvim_win_set_option(win, 'wrap', false)
        vim.api.nvim_win_set_option(win, 'cursorline', true)

        -- Add keybinding to close window
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<cr>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', '<cmd>close<cr>', { noremap = true, silent = true })
      end

      -- Set up the keybindings
      vim.keymap.set("n", "<leader>dr", M.run_dbt_model, {
        desc = "Run dbt model from current file",
        noremap = true,
        silent = true,
      })

      vim.keymap.set("n", "<leader>dt", M.transpile_dbt_model, {
        desc = "Transpile dbt model and show SQL in floating window",
        noremap = true,
        silent = true,
      })

      return M
    end,
  },
}

