return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lsp_attach = function(client, bufnr)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })

        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })

        -- -- vim.keymap.set("n", "<leader>vws",         -- --   vim.lsp.buf.workspace_symbol()
        -- -- end, opts)
        -- vim.keymap.set("n", "<leader>vd",         -- 	vim.diagnostic.open_float()
        -- end, opts)
        -- vim.keymap.set("n", "[d",         -- 	vim.diagnostic.goto_next()
        -- end, opts)
        -- vim.keymap.set("n", "]d",         -- 	vim.diagnostic.goto_prev()
        -- end, opts)

        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
      end

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local get_servers = require("mason-lspconfig").get_installed_servers
      for _, server_name in ipairs(get_servers()) do
        if server_name == "lua_ls" then
          require 'lspconfig'.lua_ls.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                  Lua = {
                    runtime = {
                      version = 'LuaJIT'
                    },
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME
                      }
                    }
                  }
                })

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
              return true
            end
          })
        elseif server_name == "pylsp" then
          lspconfig.pylsp.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = {
                    maxLineLength = 120
                  }
                }
              }
            }
          })
        else
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end
      end
      require("null-ls").setup()
      require('mason-null-ls').setup({
        ensure_installed = { 'prettier' },
        automatic_installation = true,
        handlers = {},
      })
    end
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      local rt = require('rust-tools')
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Hover" })
            vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group,
              { buffer = bufnr, desc = "Code Actions" })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          end,
        },
      })
    end
  }
}
