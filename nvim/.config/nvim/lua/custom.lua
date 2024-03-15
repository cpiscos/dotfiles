vim.api.nvim_set_keymap("n", "<leader>tw", ":set wrap!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", ":set hlsearch!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tt", ":split | wincmd j | term<CR>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber",
})
vim.api.nvim_set_keymap("n", "<leader>bn", ":bn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bp", ":bp<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bl", ":ls<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", "", {
  noremap = true,
  silent = true,
  callback = function()
    vim.fn.system("kitty . &")
  end
})
