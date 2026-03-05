-- All LSP-related plugins in one place.
-- blink.cmp is the "entry" plugin whose config wires everything together.
-- Dependencies ensure nvim-lspconfig (and its lsp/ configs) is in runtimepath
-- before vim.lsp.enable() is called.
return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "basedpyright",
          "bash-language-server",
          "efm",
          "stylua",
          "black",
          "flake8",
          "shellcheck",
          "shfmt",
          "sqlfluff",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "neovim/nvim-lspconfig",
      "creativenull/efmls-configs-nvim",
      "mason-org/mason.nvim",
    },
    config = function()
      -- ----------------------------------------------------------------
      -- Diagnostics
      -- ----------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 4 },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          focusable = false,
          style = "minimal",
        },
      })

      -- Rounded borders on all floating windows
      local orig = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig(contents, syntax, opts, ...)
      end

      -- ----------------------------------------------------------------
      -- Completion
      -- ----------------------------------------------------------------
      require("blink.cmp").setup({
        keymap = {
          preset = "none",
          ["<C-Space>"] = { "show", "hide" },
          ["<CR>"] = { "accept", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },
        appearance = { nerd_font_variant = "mono" },
        completion = { menu = { auto_show = true } },
        sources = { default = { "lsp", "path", "buffer", "snippets" } },
        snippets = {
          expand = function(snippet)
            require("luasnip").lsp_expand(snippet)
          end,
        },
        fuzzy = {
          implementation = "prefer_rust",
          prebuilt_binaries = { download = true },
        },
      })

      -- Apply blink capabilities to all LSP servers
      vim.lsp.config["*"] = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      }

      -- ----------------------------------------------------------------
      -- LSP server configs
      -- ----------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("basedpyright", {
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
      })

      vim.lsp.config("bashls", {})

      -- dbt Language Server (Fivetran)
      -- Installed globally: npm install -g @fivetrandevelopers/dbt-language-server
      -- Activates only in projects containing dbt_project.yml
      vim.lsp.config("dbt_ls", {
        cmd = { "dbt-language-server", "--stdio" },
        filetypes = { "sql", "yaml" },
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root = vim.fs.find("dbt_project.yml", { path = fname, upward = true })[1]
          if root then
            on_dir(vim.fn.fnamemodify(root, ":h"))
          end
        end,
      })

      -- ----------------------------------------------------------------
      -- EFM: linting + formatting
      -- sqlfluff is dbt-aware — set dialect in ~/.sqlfluff
      -- ----------------------------------------------------------------
      local ok, err = pcall(function()
        local luacheck = require("efmls-configs.linters.luacheck")
        local stylua = require("efmls-configs.formatters.stylua")
        local flake8 = require("efmls-configs.linters.flake8")
        local black = require("efmls-configs.formatters.black")
        local shellcheck = require("efmls-configs.linters.shellcheck")
        local shfmt = require("efmls-configs.formatters.shfmt")
        local sqlfluff_ok, sqlfluff = pcall(require, "efmls-configs.linters.sqlfluff")

        vim.lsp.config("efm", {
          filetypes = { "lua", "python", "sh", "bash", "sql" },
          init_options = { documentFormatting = true },
          settings = {
            languages = {
              lua = { luacheck, stylua },
              python = { flake8, black },
              sh = { shellcheck, shfmt },
              bash = { shellcheck, shfmt },
              sql = sqlfluff_ok and { sqlfluff } or {},
            },
          },
        })
      end)
      if not ok then
        vim.notify("efm setup failed: " .. tostring(err), vim.log.levels.WARN)
      end

      -- ----------------------------------------------------------------
      -- Enable servers
      -- ----------------------------------------------------------------
      vim.lsp.enable({
        "lua_ls",
        "basedpyright",
        "bashls",
        "efm",
        "dbt_ls",
      })

      -- ----------------------------------------------------------------
      -- LSP on-attach keymaps (buffer-local, set when LSP attaches)
      -- Note: <leader>fs and <leader>fw override the global fzf-lua
      -- live grep / grep word in LSP-attached buffers.
      -- ----------------------------------------------------------------
      local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end

          local bufnr = ev.buf
          local opts = { noremap = true, silent = true, buffer = bufnr }
          local fzf = require("fzf-lua")
          local k = vim.keymap.set

          k("n", "K", vim.lsp.buf.hover, opts)
          k("n", "gd", function()
            fzf.lsp_definitions({ jump1 = true })
          end, opts)
          k("n", "gD", vim.lsp.buf.type_definition, opts)
          k("n", "<leader>gd", function()
            fzf.lsp_definitions({ jump1 = true })
          end, opts)
          k("n", "<leader>gD", vim.lsp.buf.definition, opts)
          k("n", "<leader>gS", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
          end, opts)
          k("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          k("n", "<leader>rn", vim.lsp.buf.rename, opts)
          k("n", "<leader>D", function()
            vim.diagnostic.open_float({ scope = "line" })
          end, opts)
          k("n", "<leader>d", function()
            vim.diagnostic.open_float({ scope = "cursor" })
          end, opts)
          k("n", "<leader>nd", function()
            vim.diagnostic.jump({ count = 1 })
          end, opts)
          k("n", "<leader>pd", function()
            vim.diagnostic.jump({ count = -1 })
          end, opts)
          k("n", "gr", fzf.lsp_references, opts)
          k("n", "gi", fzf.lsp_implementations, opts)
          k("n", "<leader>fr", fzf.lsp_references, opts)
          k("n", "<leader>ft", fzf.lsp_typedefs, opts)
          k("n", "<leader>fs", fzf.lsp_document_symbols, opts)
          k("n", "<leader>fw", fzf.lsp_workspace_symbols, opts)
          k("n", "<leader>fi", fzf.lsp_implementations, opts)

          if client:supports_method("textDocument/codeAction", bufnr) then
            k("n", "<leader>oi", function()
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" }, diagnostics = {} },
                apply = true,
                bufnr = bufnr,
              })
              vim.defer_fn(function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end, 50)
            end, opts)
          end
        end,
      })
    end,
  },
}
