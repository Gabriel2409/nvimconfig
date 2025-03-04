return {
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    config = function()
      require('hardtime').setup { enabled = false }
    end,
    keys = {
      {
        mode = { 'n' },
        '<leader>uH',
        '<cmd>Hardtime toggle<cr>',
        desc = 'Toggle Hardtime',
      },
    },
  },
}
