return {
  {
    'benlubas/molten-nvim',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_output_win_max_height = 20
      vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/neovim/bin/python3'
    end,
  },
}
