return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts

  keys = {
    {
      mode = { 'n' },
      '<leader>o',
      '<cmd>Oil<cr>',
      desc = 'Oil',
    },
  },
  opts = {
    default_file_explorer = false,
  },
  -- Optional dependencies
  lazy = false,
}
