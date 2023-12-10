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

vim.cmd('colorscheme wal')
-- vim.o.termguicolors = true

if (vim.fn.exists("g:neovide")==1 and vim.fn.exists("g:terminal_color_0")==0) then
  vim.api.nvim_set_var( "terminal_color_0"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_1"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_2"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_3"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_4"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_5"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_6"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_7"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_8"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_9"  , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_10" , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_11" , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_12" , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_13" , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_14" , '#FFFFFFFF')
  vim.api.nvim_set_var( "terminal_color_15" , '#FFFFFFFF')
end
