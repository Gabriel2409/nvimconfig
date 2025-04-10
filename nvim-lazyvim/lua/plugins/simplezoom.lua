return {
  'fasterius/simple-zoom.nvim',
  opts = {
    hide_tabline = true,
  },

  keys = {
    {
      mode = { 'n' },
      '<leader>z',
      '<cmd>SimpleZoomToggle<CR><cr>',
      desc = 'Toggle zoom',
    },
    {
      mode = { 'n' },
      '<c-w>z',
      '<cmd>SimpleZoomToggle<CR><cr>',
      desc = 'Toggle zoom',
    },
  },
}
