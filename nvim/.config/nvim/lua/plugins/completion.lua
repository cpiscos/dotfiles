return {
  {
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        -- "zbirenbaum/copilot-cmp",
        { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'tzachar/fuzzy.nvim' } }
      },
      config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
          view = {

            ---@diagnostic disable-next-line: missing-fields
            entries = {
              follow_cursor = true,
            }
          },
          ---@diagnostic disable-next-line: missing-fields
          formatting = {
            format = function(_, vim_item)
              vim_item.menu = ""
              return vim_item
            end,
          },
          completion = {
            -- autocomplete = true,
            -- autocomplete = { "InsertEnter", "TextChanged" },
            -- keyword_lengh = 0,
          },
          experimental = {
            ghost_text = false,
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
          }),
          sources = cmp.config.sources({
            -- { name = "copilot" },
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
          }),

        })

        cmp.setup.filetype("lua", {
          sources = cmp.config.sources({
            -- { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },

            { name = "path" },
            { name = "nvim_lua" },
          }, {
            { name = "buffer" },
          }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }
          ),
        })

        cmp.setup.cmdline({ ":.*/", ":.*s" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }
          ),
        })
      end,
    },
    -- {
    --   "zbirenbaum/copilot.lua",
    --   cmd = "Copilot",
    --   event = "InsertEnter",
    --   config = function()
    --     require("copilot").setup({
    --       suggestion = {
    --         enabled = true,
    --         auto_trigger = true,
    --         keymap = {
    --           accept = "<C-S-Tab>",
    --         },
    --       },
    --       panel = { enabled = false },
    --       server_opts_overrides = {
    --         settings = {
    --           advanced = {
    --             inlineSuggestCount = 1,
    --             length = 20,
    --             temperature = 0,
    --
    --           },
    --         },
    --       },
    --     })
    --     vim.keymap.set("i", "<S-Tab>", require("copilot.suggestion").accept_word, { desc = "Copilot Accept Word"})
    --     vim.keymap.set("i", "<C-Tab>", require("copilot.suggestion").accept_line, { desc = "Copilot Accept Line"})
    --     vim.keymap.set("i", "<C-S-Tab>", require("copilot.suggestion").accept, { desc = "Copilot Accept"})
    --   end,
    -- },
    {
      "github/copilot.vim"
    }
  }
}
