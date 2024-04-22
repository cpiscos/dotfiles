return {
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup({
        popup_border_style = "rounded",
        sort_function = function(a, b)
          local ext_a = vim.fn.fnamemodify(a.path, ":e")
          local ext_b = vim.fn.fnamemodify(b.path, ":e")
          if a.type == b.type then
            if ext_a == ext_b then
              return a.path < b.path
            else
              return ext_a < ext_b
            end
          else
            return a.type < b.type
          end
        end,
        window = {
          position = "float",
        },
        filesystem = {
          filtered_items = {
            always_show = { ".git", ".gitignore" }
          }
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function()
              vim.opt_local.relativenumber = true
            end,
          },
        },
      })
    end,
  }
}
