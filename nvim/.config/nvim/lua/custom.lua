vim.api.nvim_set_keymap('n', '\\', ':Neotree<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', ':Neotree buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>pr', ':LspRestart<CR>:e<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tw', ':set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bc', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':q<CR>', { noremap = true, silent = true })
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
    end
  end
})

vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
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
      ['<C-h>'] = function() vim.cmd('vertical resize -5') end,
      ['<C-j>'] = function() vim.cmd('resize +5') end,
      ['<C-k>'] = function() vim.cmd('resize -5') end,
      ['<C-l>'] = function() vim.cmd('vertical resize +5') end,
    }

    for key, action in pairs(resize_mappings) do
      vim.api.nvim_set_keymap('n', key, '', {
        noremap = true,
        silent = true,
        callback = action
      })
    end
    print('Resize mode enabled (press enter to disable)')

    vim.api.nvim_set_keymap('n', '<CR>', '', {
      noremap = true,
      silent = true,
      callback = function()
        for key, _ in pairs(resize_mappings) do
          vim.api.nvim_del_keymap('n', key)
        end
        vim.api.nvim_del_keymap('n', '<CR>')
        vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
        print('Resize mode disabled')
      end
    })
  end
})

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
vim.keymap.set('n', '<leader>fk', telescope.keymaps, {})


