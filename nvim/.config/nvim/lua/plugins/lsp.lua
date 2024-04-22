local lsp_attach_ = function(bufnr)
  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr, desc = "Go to definition" })
  vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr, desc = "Go to references" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
  vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
  vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { buffer = bufnr, desc = "Diagnostic" })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",

      "pmizio/typescript-tools.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lsp_attach = function(_, bufnr)
        lsp_attach_(bufnr)
      end

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local get_servers = require("mason-lspconfig").get_installed_servers
      for _, server_name in ipairs(get_servers()) do
        if server_name == "lua_ls" then
          require("neodev").setup()
          require('lspconfig').lua_ls.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace"
                }
              }
            }
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
        elseif server_name == "tsserver" then
          require("typescript-tools").setup({
            on_attach = function()
              local bufnr = vim.api.nvim_get_current_buf()
              lsp_attach_(bufnr)
            end
          })
        elseif server_name == "cssls" then
          lspconfig.cssls.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = {
              css = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                }
              },
              scss = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                }
              },
              less = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
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
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            lsp_attach_(bufnr)
            vim.keymap.set("n", "<leader>la", function() vim.cmd.RustLsp('codeAction') end,
              { buffer = bufnr, desc = "Code Action" })
          end
        }
      }
    end,
  }
}
