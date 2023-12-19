local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("options")
require("lazy").setup("plugins")
Colors = require("custom-colors")
Colors.load()

vim.o.guifont = "JetBrainsMono Nerd Font:h12"
if vim.g.neovide then
  vim.g.neovide_refresh_rate_idle = 120
  vim.g.neovide_refresh_rate = 1000
  vim.g.neovide_hide_mouse_when_typing = true
  local map = vim.keymap.set

  local function neovideScale(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 0.5 then
      return
    end

    vim.g.neovide_scale_factor = temp
  end

  map("n", "<C-=>", function()
    neovideScale(0.1)
  end)

  map("n", "<C-->", function()
    neovideScale(-0.1)
  end)

  map("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1
  end)
end

-- vim.cmd('colorscheme wal')

-- vim.o.termguicolors = true

-- if (vim.fn.exists("g:neovide")==1 and vim.fn.exists("g:terminal_color_0")==0) then
--   vim.api.nvim_set_var( "terminal_color_0"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_1"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_2"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_3"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_4"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_5"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_6"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_7"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_8"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_9"  , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_10" , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_11" , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_12" , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_13" , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_14" , '#FFFFFFFF')
--   vim.api.nvim_set_var( "terminal_color_15" , '#FFFFFFFF')
-- end
vim.g.mapleader = " "
