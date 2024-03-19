vim.api.nvim_set_keymap('n', '<leader>lr', ':LspRestart<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tw', ':set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bl', ':ls<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bs', ':ls<CR>:b<Space>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>d', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', '', {
  noremap = true,
  silent = true,
  callback = function()
    vim.fn.system('kitty . &')
  end
})

vim.api.nvim_set_keymap('n', '<leader>tg', '', {
  noremap = true,
  silent = true,
  callback = function()
    vim.fn.system('lazygit &')
  end
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = '*',
  callback = function()
    if #vim.fn.argv() == 0 and vim.bo.filetype ~= 'help' then
      vim.cmd('Neotree reveal')
    end
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert')
    vim.cmd('setlocal nonumber norelativenumber')
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd('startinsert')

      -- local esc_key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      -- vim.defer_fn(function()
      --   vim.api.nvim_feedkeys(esc_key, 'n', true)
      -- end, 100)
    end
  end
})

vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>yp', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>yp', '"+p', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<leader>tt', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })
local terms = require('toggleterm.terminal')
vim.api.nvim_set_keymap('n', '<leader>tt', '', {
  noremap = true,
  silent = true,
  callback = function()
    local term = terms.get(1)

    if term == nil then
      terms.Terminal:new({ id = 1 }):open()
    else
      if term:is_open() then
        term:focus()
      else
        term:open()
      end
    end
  end
})
local lazygit = terms.Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
vim.api.nvim_set_keymap('n', '<leader>tg', '', {
  noremap = true,
  silent = true,
  callback = function()
    lazygit:toggle()
  end
})

vim.api.nvim_set_keymap('n', '<C-w>r', '', {
  noremap = true,
  silent = true,
  callback = function()
    local resize_mappings = {
      h = function() vim.cmd('vertical resize -1') end,
      j = function() vim.cmd('resize +1') end,
      k = function() vim.cmd('resize -1') end,
      l = function() vim.cmd('vertical resize +1') end,
    }

    for key, action in pairs(resize_mappings) do
      vim.api.nvim_set_keymap('n', key, '', {
        noremap = true,
        silent = true,
        callback = action
      })
    end

    vim.api.nvim_set_keymap('n', '<ESC>', '', {
      noremap = true,
      silent = true,
      callback = function()
        for key, _ in pairs(resize_mappings) do
          vim.api.nvim_del_keymap('n', key)
        end
        vim.api.nvim_del_keymap('n', '<ESC>')
      end
    })
  end
})
