return {
  {
    'tpope/vim-surround',
    config = function()
      vim.g["surround_no_mappings"] = 1
      vim.keymap.set("x", "gs", "<Plug>VSurround")
      vim.keymap.set("x", "gS", "<Plug>VgSurround")
    end
  },
  {
    'numToStr/Comment.nvim', lazy = false, opts = {}
  },
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end
  },
  { 'fladson/vim-kitty' },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^2.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  {
    "luckasRanarison/tree-sitter-hypr",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = { "hypr" },
        highlight = { enable = true },
      })
    end,
    build = ":TSUpdate"
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
  }
}
