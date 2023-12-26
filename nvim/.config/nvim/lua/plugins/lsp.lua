return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lsp_attach = function(client, bufnr)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })

        -- -- vim.keymap.set("n", "<leader>vws",         -- --   vim.lsp.buf.workspace_symbol()
        -- -- end, opts)
        -- vim.keymap.set("n", "<leader>vd",         -- 	vim.diagnostic.open_float()
        -- end, opts)
        -- vim.keymap.set("n", "[d",         -- 	vim.diagnostic.goto_next()
        -- end, opts)
        -- vim.keymap.set("n", "]d",         -- 	vim.diagnostic.goto_prev()
        -- end, opts)

        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

        vim.keymap.set("n", "<leader>lc", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })

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
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                      }
                      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                      -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                  }
                })

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
              return true
            end
          })
        else
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end
      end
    end
  },
}
