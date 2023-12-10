return {
  { 'deviantfero/wpgtk.vim' },
  { 'dylanaraps/wal.vim' },
  {
    'numToStr/Comment.nvim', lazy = false, opts = {}
  },
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end
  }
}
