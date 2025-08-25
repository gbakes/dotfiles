return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Dashboard configuration
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },

    -- Picker configuration
    picker = {
      hidden = true,
      sources = {
        explorer = {
          win = {
            list = {
              wo = {
                number = true,
                relativenumber = true,
              },
            },
            preview = {
              wo = {
                number = true,
                relativenumber = true,
              },
            },
          },
        },
      },
      win = {
        preview = {
          wo = {
            number = true,
            relativenumber = true,
          },
        },
      },
    },

    -- Explorer configuration
    explorer = {
      hidden = true,
    },

    -- Lazygit configuration
    lazygit = {
      -- Default settings
    },
  },

  keys = {
    -- Explorer
    {
      "<leader>ee",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },

    -- Picker/Find
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find Text",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Find Help",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Find Keymaps",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent Files",
    },

    -- Git
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },

    -- Dashboard
    {
      "<leader>bd",
      function()
        Snacks.dashboard()
      end,
      desc = "Dashboard",
    },
  },
}

