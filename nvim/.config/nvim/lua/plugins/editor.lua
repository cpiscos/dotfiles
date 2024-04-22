return {
  {
    'tpope/vim-surround',
    -- config = function()
    --   vim.g["surround_no_mappings"] = 1
    --   vim.keymap.set("x", "gs", "<Plug>VSurround")
    --   vim.keymap.set("x", "gS", "<Plug>VgSurround")
    -- end
  },
  {
    'numToStr/Comment.nvim', lazy = false, opts = {}
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup(
      ---@type Flash.Config
        {
          modes = {
            char = {
              jump_labels = true
            }
          },
          -- label = {
          --   after = true,
          --   before = true,
          -- }
        })
    end,
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  { 'fladson/vim-kitty' },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
      })

      local configs = require("nvim-treesitter.configs")
      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    'folke/neodev.nvim',
    opts = {}
  },
  {
    'simnalamburt/vim-mundo',
    config = function()
      vim.keymap.set("n", "<leader>u", ":MundoToggle<CR>")
      vim.g["mundo_width"] = 30
      vim.g["mundo_preview_bottom"] = 1
      vim.g["mundo_preview_height"] = 20
      vim.g["mundo_close_on_revert"] = 1
    end
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config({ virtual_text = false })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      require('telescope').setup({})
      require('telescope').load_extension('fzf')
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  }
}
