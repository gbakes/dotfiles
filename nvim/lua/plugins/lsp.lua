return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Python LSP - basedpyright (improved pyright fork)
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        },

        -- Lua LSP
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },

        -- YAML LSP
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
                ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
              },
              validate = true,
              completion = true,
              hover = true,
            },
          },
        },

        -- dbt Language Server
        dbt = {
          cmd = { "dbt-language-server" },
          filetypes = { "sql", "yaml" },
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("dbt_project.yml")(fname)
          end,
        },
      },
    },
  },

  -- Mason tool installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "lua-language-server",
        "yaml-language-server",
        "stylua",
        "black",
        "isort",
      },
    },
  },
}

