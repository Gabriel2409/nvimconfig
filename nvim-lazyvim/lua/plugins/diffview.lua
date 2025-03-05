return {
  -- opens diffview in a new tab.
  -- use tabclose to remove it
  'sindrets/diffview.nvim',
  keys = {
    {
      mode = { 'n' },
      '<leader>gD',
      '<cmd>DiffviewOpen<cr>',
      desc = 'DiffviewOpen',
    },
  },
}
